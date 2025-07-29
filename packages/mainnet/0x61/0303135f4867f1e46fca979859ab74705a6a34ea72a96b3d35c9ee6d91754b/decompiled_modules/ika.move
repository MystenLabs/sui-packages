module 0x610303135f4867f1e46fca979859ab74705a6a34ea72a96b3d35c9ee6d91754b::ika {
    struct IKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: IKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IKA>(arg0, 9, b"IKA", b"IKA Token", b"Ika Protocol.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://docs.dwallet.io/img/logo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IKA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<IKA>>(0x2::coin::mint<IKA>(&mut v2, 10000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<IKA>>(v2);
    }

    // decompiled from Move bytecode v6
}

