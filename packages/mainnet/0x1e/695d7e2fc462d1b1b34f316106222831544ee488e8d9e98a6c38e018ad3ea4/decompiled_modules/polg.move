module 0x1e695d7e2fc462d1b1b34f316106222831544ee488e8d9e98a6c38e018ad3ea4::polg {
    struct POLG has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLG>(arg0, 6, b"POLG", b"Pepe Gold On Sui", b"The golden standard of meme coins.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/06a49e_16289c801a8a44f08eee6ab15f044340_mv2_9caf04f82f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POLG>>(v1);
    }

    // decompiled from Move bytecode v6
}

