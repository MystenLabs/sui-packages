module 0xe417e4a204994a96053a2220d04c7b9083ba48e565d8df4fd4cd491f93bc95db::mommas {
    struct MOMMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOMMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOMMAS>(arg0, 6, b"Mommas", b"Fat Mommas", b"Big ladies, big laughs, and even bigger gains!  Fat Mommas Coin: The heavyweight champ of meme crypto. Check out our socials and art. If you like to laugh and make BIG gains, that's what Fat Mommas is about. Check out our TG and X art.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fat_Mommas_4_12d575ca34.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOMMAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOMMAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

