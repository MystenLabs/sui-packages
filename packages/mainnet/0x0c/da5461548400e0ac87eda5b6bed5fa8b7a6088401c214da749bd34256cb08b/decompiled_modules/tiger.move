module 0xcda5461548400e0ac87eda5b6bed5fa8b7a6088401c214da749bd34256cb08b::tiger {
    struct TIGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIGER>(arg0, 6, b"TIGER", b"SUITIGER", b"SUITIGER aims to help wild animals and endangered animals in the evolving and developing world, and we will transfer a portion of our profits to the rescue of these animals", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000197966_aae01f9e83.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIGER>>(v1);
    }

    // decompiled from Move bytecode v6
}

