module 0x6b14d426f949d23765450911784fe5cdd94dcb46ed6a53baca155c23f34ee3a0::kai {
    struct KAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAI>(arg0, 6, b"Kai", b"KendoAI", b"Kendo ai is an ai sales training and management tool used to improve the skill of sales reps and help sales managers do their jobs more efficiently.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2232_273aab31b6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

