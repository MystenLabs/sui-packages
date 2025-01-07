module 0x98bcc76bed09b4dc138c75262f91d2e09768c8db874cac81517c2b3b93c71f62::munchy {
    struct MUNCHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUNCHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUNCHY>(arg0, 6, b"Munchy", b"Munchy Coin", b"Im Munchy Coin, the memecoin that satisfies your craving for fun and gains!  Whether youre stacking crypto or just here for the laughs, I bring a tasty mix of humor and community. Join the munch and let's take a sweet ride to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_27_19_20_29_823f268570.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUNCHY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUNCHY>>(v1);
    }

    // decompiled from Move bytecode v6
}

