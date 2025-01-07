module 0x762ee76fbfc9ca1d81adf8d0233879911c1c02688781ad5bef06ccb33ac3505b::seek {
    struct SEEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEEK>(arg0, 6, b"SEEK", b"Seeker", x"5365656b657273206275696c6465696e672061206e657720636f6d6d756e69747920696e205355492e0a5765207365656b20666f72206e6577207465616d206d656d626572732e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000515_210d383c8d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEEK>>(v1);
    }

    // decompiled from Move bytecode v6
}

