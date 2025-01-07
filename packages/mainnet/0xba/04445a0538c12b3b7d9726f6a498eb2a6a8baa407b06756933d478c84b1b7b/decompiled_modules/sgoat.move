module 0xba04445a0538c12b3b7d9726f6a498eb2a6a8baa407b06756933d478c84b1b7b::sgoat {
    struct SGOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGOAT>(arg0, 6, b"sGOAT", b"sGOAT On Sui", b"sGOAT, is a meme token launched by the largest Fantom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x43f9a13675e352154f745d6402e853fecc388aa5_9365c21e72.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGOAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

