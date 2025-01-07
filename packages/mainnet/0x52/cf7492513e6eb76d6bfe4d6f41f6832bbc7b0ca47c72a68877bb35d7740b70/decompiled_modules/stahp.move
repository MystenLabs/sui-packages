module 0x52cf7492513e6eb76d6bfe4d6f41f6832bbc7b0ca47c72a68877bb35d7740b70::stahp {
    struct STAHP has drop {
        dummy_field: bool,
    }

    fun init(arg0: STAHP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STAHP>(arg0, 6, b"STAHP", b"Stahp on sui", b"$STAHP. Inspired by the iconic STAHP meme  stahp stressing, start laughing and enjoy the lighter side of life!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000054613_fa8b2e6560.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STAHP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STAHP>>(v1);
    }

    // decompiled from Move bytecode v6
}

