module 0xae42002f7d05d9c04d6894f9d1b3e5818c17ff09761b513fce83028956ec92e8::tomoflys {
    struct TOMOFLYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOMOFLYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOMOFLYS>(arg0, 6, b"Tomoflys", b"Tomoflys On Sui", b"Join https://t.me/+5NuQMp_vQhhkNTJk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tomoflys_edc3fe50f5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOMOFLYS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOMOFLYS>>(v1);
    }

    // decompiled from Move bytecode v6
}

