module 0x7969646e6e90a91c09b32f6ce1e7d5466092286ac8b9de651c90fcca4185e19f::bowl {
    struct BOWL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOWL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOWL>(arg0, 6, b"BOWL", b"Fish In a Bowl", b"Bowl is big memecoin next Billion on sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048996_deb056ae0c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOWL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOWL>>(v1);
    }

    // decompiled from Move bytecode v6
}

