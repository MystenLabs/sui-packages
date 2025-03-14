module 0xe8cfd6e60a89ff7bf0f57e77decadd9482b1642781926392b5671435497ec65a::lofi {
    struct LOFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOFI>(arg0, 9, b"LOFI", b"Lofi", b"Lofi is everyone's favorite Yeti on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/fM8QZXh/LOFI-PFP.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOFI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<LOFI>>(0x2::coin::mint<LOFI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LOFI>>(v2);
    }

    // decompiled from Move bytecode v6
}

