module 0x8bbbd93657e5c26c50fa50740a5f9b2205bb02341a9c67601450d2ceebb498f5::dmagas {
    struct DMAGAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DMAGAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMAGAS>(arg0, 6, b"DMAGAS", b"Dark MAGA Sui", b"Dark MAGA Sui patriots in control!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4927479850168593976_37b0193334.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMAGAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DMAGAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

