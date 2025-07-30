module 0x8b1e98e1bfd437e4ae3e6dfe16f336487bca0d5468712251f190c974af4b8147::HOWL {
    struct HOWL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOWL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOWL>(arg0, 6, b"HowlFi", b"HOWL", b"HowlFi is the ultimate meme coin for anime wolf lovers! Inspired by legendary anime wolves like Sif from Dark Souls and Holo from Spice & Wolf, HOWL brings fun, community, and moon-howling energy to the crypto world. Join the pack and let's howl to the moon together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://replicate.delivery/xezq/hr6kkP2f4SSwFaOLQ6oTaNYcYWEVST0hOETb7iwdI29j2fFVA/out-0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOWL>>(v0, @0x82ea3f8d2475bae1d2aba484c46125fdb81e0f192172e398c2ee99d9813cea00);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOWL>>(v1);
    }

    // decompiled from Move bytecode v6
}

