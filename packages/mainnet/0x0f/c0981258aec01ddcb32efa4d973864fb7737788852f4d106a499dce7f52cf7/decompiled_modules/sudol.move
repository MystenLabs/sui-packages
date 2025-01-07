module 0xfc0981258aec01ddcb32efa4d973864fb7737788852f4d106a499dce7f52cf7::sudol {
    struct SUDOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUDOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUDOL>(arg0, 6, b"SUDOL", b"SUI DOLPHIN", b"In the vast sea of crypto, $SUDOL is the sleek dolphin guiding you through the waves of profits!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUDOL_9b6e02dec6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUDOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUDOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

