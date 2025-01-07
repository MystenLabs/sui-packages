module 0x4175eb0b11560d69413f0bc8f4fea1dfdc5ad38a06352582bd819fe5de77072::zona {
    struct ZONA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZONA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZONA>(arg0, 6, b"ZONA", b"Survive Zona", x"4d6565742074686520245a4f4e412070726f6a6563742c20612067616d65206275696c74206f6e207468652053554920436861696e2e0a50617274206f6620746865205a4f4e412070726f6a65637420737570706f7274696e672074686520245a4f4e4120636f696e2c20706c6163657320706c617965727320696e20636c6173736963205275737369616e20707269736f6e20736974756174696f6e732e200a4d616b6520637269746963616c206465636973696f6e732c206275696c6420796f75722072657075746174696f6e2c20616e6420696e63726561736520796f757220696e666c75656e63652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241201_202237_843_2ea14a8228.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZONA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZONA>>(v1);
    }

    // decompiled from Move bytecode v6
}

