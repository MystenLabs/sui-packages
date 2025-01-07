module 0x19fc123c115b38c40e01b89f5a6389101dea133d970678df5f8d57f4d5f71663::bread {
    struct BREAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BREAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BREAD>(arg0, 6, b"Bread", b"Baked", b"Baked Bread", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732311792601.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BREAD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BREAD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

