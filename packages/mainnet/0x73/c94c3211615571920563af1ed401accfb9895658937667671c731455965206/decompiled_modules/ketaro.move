module 0x73c94c3211615571920563af1ed401accfb9895658937667671c731455965206::ketaro {
    struct KETARO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KETARO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KETARO>(arg0, 6, b"KETARO", b"ketaro.su", b"SUI Co Founder meme coin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_1_01_dcb7eefaac.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KETARO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KETARO>>(v1);
    }

    // decompiled from Move bytecode v6
}

