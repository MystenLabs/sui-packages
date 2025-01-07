module 0xedce904abeeafd38fa335a3e85540828abef04b8dfb04de87640c03b14c5b233::fish {
    struct FISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISH>(arg0, 6, b"FISH", b"Fishio", b"Fishio just swam onto the Sui network! How much is the fish?' Enough to make waves! Dive in, have a laugh, and ride the tide of the funniest memecoin aroud", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hm_M4_FHT_400x400_2c48ead49b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

