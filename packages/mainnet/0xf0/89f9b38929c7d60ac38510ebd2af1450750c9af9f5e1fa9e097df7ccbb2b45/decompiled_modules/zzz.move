module 0xf089f9b38929c7d60ac38510ebd2af1450750c9af9f5e1fa9e097df7ccbb2b45::zzz {
    struct ZZZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZZZ>(arg0, 6, b"ZZZ", b"zzz fly", x"497427732074696d6520746f2064657468726f6e652074686520636174200a43616e27742073746f7020776f6e27742073746f7020287468696e6b696e672061626f75742053686974290a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pfp_786c693ad6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZZZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZZZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

