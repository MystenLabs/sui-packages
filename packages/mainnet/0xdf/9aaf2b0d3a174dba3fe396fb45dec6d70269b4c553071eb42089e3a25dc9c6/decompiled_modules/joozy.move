module 0xdf9aaf2b0d3a174dba3fe396fb45dec6d70269b4c553071eb42089e3a25dc9c6::joozy {
    struct JOOZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOOZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOOZY>(arg0, 6, b"JOOZY", b"JOOZY ASSISTANT", b"Dapps that has revolutionized the way people interact with the Web3. With its features, allows users to seamlessly interact. Launched on SUI Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_08_13_21_34_58_a87618b399.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOOZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOOZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

