module 0x7bb432c18ae568c16835cb9163d24afe03c0bfbf134600d97eef1f339d78f672::snwhl {
    struct SNWHL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNWHL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNWHL>(arg0, 6, b"SNwhl", b"Sui Narwhal", b"Narwhal Coin is here to make waves on the Sui chain! Inspired by the mystical and playful spirit of the narwhal often called the unicorn of the sea this meme coin blends fun, community spirit, and the decentralized power of blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Kj2_GTEWAA_Eq8k_Q_1_dfa1853dc1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNWHL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNWHL>>(v1);
    }

    // decompiled from Move bytecode v6
}

