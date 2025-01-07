module 0xa24a434d41d84bac17f3b63036d3320b4116b1a5f71cdf722aa25405e7a05067::boucher {
    struct BOUCHER has drop {
        dummy_field: bool,
    }

    struct Boucher has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>,
    }

    struct MintCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintEvent has copy, drop {
        boucher_id: 0x2::object::ID,
        value: u64,
    }

    struct RedeemEvent has copy, drop {
        boucher_id: 0x2::object::ID,
        value: u64,
    }

    struct DepositEvent has copy, drop {
        fund_amount: u64,
    }

    public fun batch_mint_to(arg0: &MintCap, arg1: u64, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg2) {
            0x2::transfer::transfer<Boucher>(mint(arg0, arg1, arg4), arg3);
            v0 = v0 + 1;
        };
    }

    public fun deposit(arg0: &mut Treasury, arg1: 0x2::coin::Coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>) {
        let v0 = DepositEvent{fund_amount: 0x2::coin::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&arg1)};
        0x2::event::emit<DepositEvent>(v0);
        0x2::coin::put<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut arg0.balance, arg1);
    }

    fun init(arg0: BOUCHER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"BUCK Voucher"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ipfs.io/ipfs/QmWDTiFbLwqX2ajAjDvqxhMhWGVjVbzi6mn2ufXVM8kM6i"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Go https://app.bucketprotocol.io/basecamp to get some $BUCK and enjoy the Bucket ecosystem!"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://app.bucketprotocol.io/basecamp"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Bucket Protocol"));
        let v4 = 0x2::package::claim<BOUCHER>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Boucher>(&v4, v0, v2, arg1);
        0x2::display::update_version<Boucher>(&mut v5);
        let v6 = MintCap{id: 0x2::object::new(arg1)};
        let v7 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v7);
        0x2::transfer::public_transfer<0x2::display::Display<Boucher>>(v5, v7);
        0x2::transfer::public_transfer<MintCap>(v6, v7);
        let v8 = Treasury{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(),
        };
        0x2::transfer::share_object<Treasury>(v8);
    }

    public fun mint(arg0: &MintCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Boucher {
        let v0 = Boucher{
            id    : 0x2::object::new(arg2),
            value : arg1,
        };
        let v1 = MintEvent{
            boucher_id : 0x2::object::id<Boucher>(&v0),
            value      : arg1,
        };
        0x2::event::emit<MintEvent>(v1);
        v0
    }

    public fun redeem(arg0: &mut Treasury, arg1: Boucher, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK> {
        let Boucher {
            id    : v0,
            value : v1,
        } = arg1;
        0x2::object::delete(v0);
        let v2 = RedeemEvent{
            boucher_id : 0x2::object::id<Boucher>(&arg1),
            value      : v1,
        };
        0x2::event::emit<RedeemEvent>(v2);
        0x2::coin::take<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut arg0.balance, v1, arg2)
    }

    // decompiled from Move bytecode v6
}

