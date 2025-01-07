module 0x4a115cf4d94f3a065fd617cee73d3af60c8dbb4b69ed1a79679fb6c91680b5d5::scarrot {
    struct SCARROT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCARROT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCARROT>(arg0, 9, b"SCARROT", b"Scarrot.MM", b"Vegetable for healthy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/df5f5793-fdce-4330-88c6-b9e2fc21272a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCARROT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCARROT>>(v1);
    }

    // decompiled from Move bytecode v6
}

