module 0x9c8bcbf95d45580d1f71474deb696e4b8c8bcfc04134846b598a4d8777deb030::ars {
    struct ARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARS>(arg0, 6, b"Ars", b"AUREUS", b"Ancient gold meets modern internet culture. Bringing a rich, playful twist to the meme coin world combining history, humor, and community spirit. A treasure hunt for the for the digital age. Empire of fun and fortune. Imagination, Joy and Laughter!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1745859487348.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

