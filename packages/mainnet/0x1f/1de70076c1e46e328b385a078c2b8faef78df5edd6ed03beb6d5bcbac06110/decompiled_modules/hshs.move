module 0x1f1de70076c1e46e328b385a078c2b8faef78df5edd6ed03beb6d5bcbac06110::hshs {
    struct HSHS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HSHS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HSHS>(arg0, 9, b"HSHS", b"Okay", b"probably nothing ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/89c24dd3-87e7-4fd3-a5a6-83d6b1dd69c2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HSHS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HSHS>>(v1);
    }

    // decompiled from Move bytecode v6
}

