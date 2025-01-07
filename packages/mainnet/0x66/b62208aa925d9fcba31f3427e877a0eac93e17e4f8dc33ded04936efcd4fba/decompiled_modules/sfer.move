module 0x66b62208aa925d9fcba31f3427e877a0eac93e17e4f8dc33ded04936efcd4fba::sfer {
    struct SFER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFER>(arg0, 6, b"SFER", b"Sui motherfucka", b"We are being mfers to sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_c87e94e46b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFER>>(v1);
    }

    // decompiled from Move bytecode v6
}

