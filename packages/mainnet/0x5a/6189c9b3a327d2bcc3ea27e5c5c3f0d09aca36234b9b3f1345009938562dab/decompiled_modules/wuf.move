module 0x5a6189c9b3a327d2bcc3ea27e5c5c3f0d09aca36234b9b3f1345009938562dab::wuf {
    struct WUF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUF>(arg0, 6, b"WUF", b"SUI WUF", b"$WUF is more than just a meme token  its a community-driven takeover on the Sui Blockchain. Inspired by the legendary dog-themed memecoins that have taken the crypto world by storm, $WUF brings a fresh wave of energy, humor, and opportunity to the space", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000037436_d0a9d8f198.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WUF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WUF>>(v1);
    }

    // decompiled from Move bytecode v6
}

