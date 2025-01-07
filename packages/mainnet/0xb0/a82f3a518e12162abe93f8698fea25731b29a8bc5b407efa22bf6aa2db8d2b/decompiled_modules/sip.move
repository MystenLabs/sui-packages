module 0xb0a82f3a518e12162abe93f8698fea25731b29a8bc5b407efa22bf6aa2db8d2b::sip {
    struct SIP has drop {
        dummy_field: bool,
    }

    struct SIPStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<SIP>,
        minters: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct SIPAdminCap has key {
        id: 0x2::object::UID,
    }

    struct MinterAdded has copy, drop {
        id: 0x2::object::ID,
    }

    struct MinterRemoved has copy, drop {
        id: 0x2::object::ID,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<SIP>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SIP>>(arg0, arg1);
    }

    public entry fun add_minter(arg0: &SIPAdminCap, arg1: &mut SIPStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.minters, arg2);
        let v0 = MinterAdded{id: arg2};
        0x2::event::emit<MinterAdded>(v0);
    }

    public fun admin_mint(arg0: &SIPAdminCap, arg1: &mut SIPStorage, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SIP>>(0x2::coin::from_balance<SIP>(0x2::balance::increase_supply<SIP>(&mut arg1.supply, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public fun burn(arg0: &mut SIPStorage, arg1: 0x2::coin::Coin<SIP>) : u64 {
        0x2::balance::decrease_supply<SIP>(&mut arg0.supply, 0x2::coin::into_balance<SIP>(arg1))
    }

    fun init(arg0: SIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIP>(arg0, 9, b"dwfdsf", b"sdfsdf", b"Siphon token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://liquidify.space/logo.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SIP>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = 0x2::coin::treasury_into_supply<SIP>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<SIP>>(0x2::coin::from_balance<SIP>(0x2::balance::increase_supply<SIP>(&mut v3, 600000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v4 = SIPAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<SIPAdminCap>(v4, 0x2::tx_context::sender(arg1));
        let v5 = SIPStorage{
            id      : 0x2::object::new(arg1),
            supply  : v3,
            minters : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<SIPStorage>(v5);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIP>>(v1);
    }

    public fun is_minter(arg0: &SIPStorage, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.minters, &arg1)
    }

    public fun mint(arg0: &mut SIPStorage, arg1: &0x2::package::Publisher, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SIP> {
        assert!(is_minter(arg0, 0x2::object::id<0x2::package::Publisher>(arg1)), 1);
        0x2::coin::from_balance<SIP>(0x2::balance::increase_supply<SIP>(&mut arg0.supply, arg2), arg3)
    }

    public entry fun remove_minter(arg0: &SIPAdminCap, arg1: &mut SIPStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::remove<0x2::object::ID>(&mut arg1.minters, &arg2);
        let v0 = MinterRemoved{id: arg2};
        0x2::event::emit<MinterRemoved>(v0);
    }

    public fun total_supply(arg0: &SIPStorage) : u64 {
        0x2::balance::supply_value<SIP>(&arg0.supply)
    }

    // decompiled from Move bytecode v6
}

