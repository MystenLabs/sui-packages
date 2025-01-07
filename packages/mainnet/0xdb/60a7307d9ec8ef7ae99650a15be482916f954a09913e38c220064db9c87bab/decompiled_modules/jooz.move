module 0xdb60a7307d9ec8ef7ae99650a15be482916f954a09913e38c220064db9c87bab::jooz {
    struct JOOZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOOZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOOZ>(arg0, 6, b"JOOZ", b"JOOZY", b"Dapps that has revolutionized the way people interact with the Web3. With its features, allows users to seamlessly interact. Launched on SUI Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_08_13_21_34_58_c51d54dfd3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOOZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOOZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

