module 0x641dd3449505b1dd24cc75351cc230d6e521c3af6a420c281ae856db28171625::forkysui {
    struct FORKYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FORKYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FORKYSUI>(arg0, 6, b"Forkysui", b"Forky Sui", b"First meme coin on sui tap 500m mc.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000007494_168d1ec581.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FORKYSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FORKYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

