module 0x56074c5bde5622771a86783c99cb16f513c2efb743d5174fd8f71f7c210fa126::gib {
    struct GIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIB>(arg0, 6, b"GIB", b"GibtheFrog", b"The gibthefrogs big eyes and red exclamation marks scream FOMO meme coin and fun perfect for virality.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigjsn426fqztt3fg4pqdfqp6c7nmfwz637pj52bqtg57ftmpf23mm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GIB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

