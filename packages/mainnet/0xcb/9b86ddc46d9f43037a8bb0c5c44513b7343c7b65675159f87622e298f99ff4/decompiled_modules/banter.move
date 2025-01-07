module 0xcb9b86ddc46d9f43037a8bb0c5c44513b7343c7b65675159f87622e298f99ff4::banter {
    struct BANTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANTER>(arg0, 6, b"BANTER", b"Crypto Banter", b"The Worlds No.1 LIVE Crypto Streaming Channel. Covering Bitcoin, Breaking news, hottest stories, Altcoins, top Founders and Billionaires next big Market Moves, every single day. Crypto Banter is the best on YouTube bring crypto alpha to the community daily", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_13_11_2024_19269_www_bing_com_7da6472f25.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BANTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

