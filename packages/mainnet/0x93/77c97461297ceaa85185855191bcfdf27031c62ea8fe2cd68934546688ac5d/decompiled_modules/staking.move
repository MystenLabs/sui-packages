module 0x4edaf43ada89b42ba4dee9fbf74a4dee3eb01f3cfd311d4fb2c6946f87952e51::staking {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GemManager has key {
        id: 0x2::object::UID,
        version: u64,
        claim_enabled: bool,
        total_staked: u64,
        cap: 0x2::coin::TreasuryCap<0xd2abc9c614ef2aaa28ba5f1c61c682883235025c6691ce3bcbde0ec6f89b699::gems::GEMS>,
    }

    struct AccountRegistry has key {
        id: 0x2::object::UID,
        accounts: 0x2::table::Table<address, 0x2::object::ID>,
    }

    struct Account has key {
        id: 0x2::object::UID,
        to_claim: u64,
        nfts: vector<Staked>,
    }

    struct Staked has store {
        last_updated: u64,
        nft: 0x4edaf43ada89b42ba4dee9fbf74a4dee3eb01f3cfd311d4fb2c6946f87952e51::dlab::Dlab,
    }

    public fun destroy_empty(arg0: &mut AccountRegistry, arg1: Account, arg2: &0x2::tx_context::TxContext) {
        let Account {
            id       : v0,
            to_claim : v1,
            nfts     : v2,
        } = arg1;
        0x2::object::delete(v0);
        0x1::vector::destroy_empty<Staked>(v2);
        assert!(v1 == 0, 1);
        0x2::table::remove<address, 0x2::object::ID>(&mut arg0.accounts, 0x2::tx_context::sender(arg2));
    }

    public fun claim(arg0: &mut GemManager, arg1: &mut Account, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.claim_enabled, 3);
        let v0 = arg1.to_claim;
        let v1 = &mut arg1.nfts;
        let v2 = 0;
        while (v2 < 0x1::vector::length<Staked>(v1)) {
            let v3 = 0x1::vector::borrow_mut<Staked>(v1, v2);
            v0 = v0 + 0x2::tx_context::epoch(arg2) - v3.last_updated;
            v3.last_updated = 0x2::tx_context::epoch(arg2);
            v2 = v2 + 1;
        };
        0x2::token::keep<0xd2abc9c614ef2aaa28ba5f1c61c682883235025c6691ce3bcbde0ec6f89b699::gems::GEMS>(0x2::token::mint<0xd2abc9c614ef2aaa28ba5f1c61c682883235025c6691ce3bcbde0ec6f89b699::gems::GEMS>(&mut arg0.cap, v0, arg2), arg2);
        arg1.to_claim = 0;
    }

    public fun init_staking(arg0: 0x2::coin::TreasuryCap<0xd2abc9c614ef2aaa28ba5f1c61c682883235025c6691ce3bcbde0ec6f89b699::gems::GEMS>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GemManager{
            id            : 0x2::object::new(arg1),
            version       : 1,
            claim_enabled : false,
            total_staked  : 0,
            cap           : arg0,
        };
        0x2::transfer::share_object<GemManager>(v0);
        let v1 = AccountRegistry{
            id       : 0x2::object::new(arg1),
            accounts : 0x2::table::new<address, 0x2::object::ID>(arg1),
        };
        0x2::transfer::share_object<AccountRegistry>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun keep_account(arg0: &mut AccountRegistry, arg1: Account, arg2: &0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg0.accounts, 0x2::tx_context::sender(arg2)), 4);
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.accounts, 0x2::tx_context::sender(arg2), 0x2::object::uid_to_inner(&arg1.id));
        0x2::transfer::transfer<Account>(arg1, 0x2::tx_context::sender(arg2));
    }

    public fun new_account(arg0: &mut 0x2::tx_context::TxContext) : Account {
        Account{
            id       : 0x2::object::new(arg0),
            to_claim : 0,
            nfts     : 0x1::vector::empty<Staked>(),
        }
    }

    public entry fun new_admin(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<AdminCap>(v0, arg1);
    }

    public fun stake(arg0: &mut GemManager, arg1: &mut Account, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::object::ID, arg4: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<0x4edaf43ada89b42ba4dee9fbf74a4dee3eb01f3cfd311d4fb2c6946f87952e51::dlab::Dlab, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Staked{
            last_updated : 0x2::tx_context::epoch(arg5),
            nft          : 0x4edaf43ada89b42ba4dee9fbf74a4dee3eb01f3cfd311d4fb2c6946f87952e51::dlab::withdraw_from_kiosk(arg4, arg2, arg3, arg5),
        };
        0x1::vector::push_back<Staked>(&mut arg1.nfts, v0);
        arg0.total_staked = arg0.total_staked + 1;
    }

    public fun to_claim(arg0: &Account) : u64 {
        arg0.to_claim
    }

    public entry fun toggle_claim(arg0: &AdminCap, arg1: &mut GemManager) {
        arg1.claim_enabled = !arg1.claim_enabled;
    }

    public fun unstake(arg0: &mut GemManager, arg1: &mut Account, arg2: &mut 0x2::kiosk::Kiosk, arg3: vector<0x2::object::ID>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        0x1::vector::reverse<0x2::object::ID>(&mut arg3);
        while (0x1::vector::length<0x2::object::ID>(&arg3) != 0) {
            let v1 = &arg1.nfts;
            let v2 = 0;
            let v3;
            while (v2 < 0x1::vector::length<Staked>(v1)) {
                if (0x2::object::id<0x4edaf43ada89b42ba4dee9fbf74a4dee3eb01f3cfd311d4fb2c6946f87952e51::dlab::Dlab>(&0x1::vector::borrow<Staked>(v1, v2).nft) == 0x1::vector::pop_back<0x2::object::ID>(&mut arg3)) {
                    v3 = 0x1::option::some<u64>(v2);
                    /* label 9 */
                    assert!(0x1::option::is_some<u64>(&v3), 2);
                    let Staked {
                        last_updated : v4,
                        nft          : v5,
                    } = 0x1::vector::swap_remove<Staked>(&mut arg1.nfts, 0x1::option::destroy_some<u64>(v3));
                    v0 = v0 + 0x2::tx_context::epoch(arg4) - v4;
                    0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<0x4edaf43ada89b42ba4dee9fbf74a4dee3eb01f3cfd311d4fb2c6946f87952e51::dlab::Dlab>(arg2, v5, arg4);
                    arg0.total_staked = arg0.total_staked - 1;
                    /* goto 1 */
                    continue
                };
                v2 = v2 + 1;
            };
            v3 = 0x1::option::none<u64>();
            /* goto 9 */
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg3);
        if (arg0.claim_enabled) {
            arg1.to_claim = arg1.to_claim + v0;
        } else {
            arg1.to_claim = arg1.to_claim + v0 / 2;
        };
    }

    // decompiled from Move bytecode v6
}

