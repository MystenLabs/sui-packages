module 0x9e3590d28ef47ba6ac04584f44ceeeb92fe38a0bcb527a2b03b723772dccd7e3::News_Channel {
    struct NEWS_CHANNEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEWS_CHANNEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEWS_CHANNEL>(arg0, 9, b"NEWS", b"News Channel", b"here is the news. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1774198587095646208/6KEF61Mv_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEWS_CHANNEL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEWS_CHANNEL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

