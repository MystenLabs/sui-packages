module 0xe7e089381a86cd5232e1d0f521a05ae5e743fb15f5ea46c7eb6f7938f1a4eb1d::crossfi {
    struct CROSSFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROSSFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROSSFI>(arg0, 6, b"CrossFi", b"XFI", b"CrossFi is the first cross-chain compatible ecosystem that allows interoperability between crypto and fiat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000409525_8eb6b6a509.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROSSFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CROSSFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

