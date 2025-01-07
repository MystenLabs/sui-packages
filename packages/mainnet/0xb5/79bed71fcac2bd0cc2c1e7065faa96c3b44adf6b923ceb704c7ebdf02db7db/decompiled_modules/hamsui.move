module 0xb579bed71fcac2bd0cc2c1e7065faa96c3b44adf6b923ceb704c7ebdf02db7db::hamsui {
    struct HAMSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAMSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAMSUI>(arg0, 6, b"Hamsui", b"Hamster on sui", b"The real hamster meme on sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000043443_57403cb5d4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAMSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAMSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

