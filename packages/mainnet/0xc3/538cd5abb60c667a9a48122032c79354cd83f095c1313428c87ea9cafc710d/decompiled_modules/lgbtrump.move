module 0xc3538cd5abb60c667a9a48122032c79354cd83f095c1313428c87ea9cafc710d::lgbtrump {
    struct LGBTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: LGBTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LGBTRUMP>(arg0, 6, b"LGBTRUMP", b"LGBT for TRUMP", b"Introducing LGBT for TRUMP, a revolutionary meme coin that bridges diverse communities under a shared banner of inclusivity, humor, and progress. This is not just a cryptocurrencyit's a movement.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/trumplgbt_1fd5d49257.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LGBTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LGBTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

