module 0x3d5bf6587d6b1f65fc80640141baf7276c72820c2c97df5e5637aae0fcefddee::trumpcat {
    struct TRUMPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPCAT>(arg0, 6, b"TRUMPCAT", b"Trump Cat Leader", x"5472756d7020737570706f7274657220f09f90be207c20436174206c6f766572", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730961357608.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

