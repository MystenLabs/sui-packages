module 0x82c6652ee996af0088cd675967432549c27ab94e5ba8a25c284d99e3e6d63290::dln {
    struct DLN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DLN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DLN>(arg0, 9, b"DLN", b"DollarLion", b"A big lion Made by Billion of dollar. Each part of his body is a real dollar.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dccea693-aef2-4549-9cb3-ff6a9995c305.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DLN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DLN>>(v1);
    }

    // decompiled from Move bytecode v6
}

