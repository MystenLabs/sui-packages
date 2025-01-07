module 0xecc75fb283552723edb0e41486cada9293fbd74e59ee88b0ba4d12219047d30c::scrappy {
    struct SCRAPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCRAPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCRAPPY>(arg0, 6, b"SCRAPPY", b"Scrappy on Sui", b"Scrappy is the first-ever original meme coin on the Sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7363726170000000000000000000000000000000_rghtynnigyuahehwgfadoehkoirkgndzzo_1_3b26bb8d09.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCRAPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCRAPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

