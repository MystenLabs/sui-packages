module 0x64bd4d2c30be8af6134c113a6e8ee1b5c3ebd887316042173b1d4a1bf767d428::asu {
    struct ASU has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASU>(arg0, 6, b"Asu", b"aaaaaa asuuu", b"asuasuasuasu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7011_d36232c846.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASU>>(v1);
    }

    // decompiled from Move bytecode v6
}

