module 0xd9454cd75ea1b659a6d60a79c451715afeade080b158074ef0d6194a29f41802::fishsui {
    struct FISHSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHSUI>(arg0, 6, b"Fishsui", b"Fish on sui", b"Fish.....", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000904579_f0145ea334.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISHSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

