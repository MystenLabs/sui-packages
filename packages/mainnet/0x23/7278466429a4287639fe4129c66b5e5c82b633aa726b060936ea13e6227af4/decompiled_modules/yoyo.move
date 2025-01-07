module 0x237278466429a4287639fe4129c66b5e5c82b633aa726b060936ea13e6227af4::yoyo {
    struct YOYO has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOYO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOYO>(arg0, 6, b"YOYO", b"Yoyo", b"Yo, it's Yoyo the cat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/yoyo_df29b9837d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOYO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOYO>>(v1);
    }

    // decompiled from Move bytecode v6
}

