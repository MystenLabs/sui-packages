module 0x1454818126d0c86cd7b632452dc5e9f8825b98ae3f94aae7065449c7cb00591f::narwhal {
    struct NARWHAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NARWHAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NARWHAL>(arg0, 6, b"Narwhal", b"Narwhal On Sui", b"An adorably oblivious narwhal who's always making waves in the deep sea, riding through chaos with a goofy grin!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_05_19_29_28_be19dbfbc6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NARWHAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NARWHAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

