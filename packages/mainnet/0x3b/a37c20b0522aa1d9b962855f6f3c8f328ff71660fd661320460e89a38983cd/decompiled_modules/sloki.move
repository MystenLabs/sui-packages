module 0x3ba37c20b0522aa1d9b962855f6f3c8f328ff71660fd661320460e89a38983cd::sloki {
    struct SLOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLOKI>(arg0, 6, b"SLOKI", b"Sui Floki", b"Floki is a popular meme-coin embraced by the community. Its time for Floki to dominate the SUI Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sloki_Logo_6b241400f1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLOKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLOKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

