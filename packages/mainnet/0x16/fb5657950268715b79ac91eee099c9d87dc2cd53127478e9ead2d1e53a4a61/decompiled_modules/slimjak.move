module 0x16fb5657950268715b79ac91eee099c9d87dc2cd53127478e9ead2d1e53a4a61::slimjak {
    struct SLIMJAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLIMJAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLIMJAK>(arg0, 6, b"SLIMJAK", b"Slimjak Sui", b"Slimjak is Wojak's skinny twin brother that became a global meme icon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/prop_ba3e5a5a87.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLIMJAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLIMJAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

