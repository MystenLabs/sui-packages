module 0xcf2102b524597a225ef47d33e8b585a1df8240fcc8745042df840e46ac5f786d::iphone16 {
    struct IPHONE16 has drop {
        dummy_field: bool,
    }

    fun init(arg0: IPHONE16, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IPHONE16>(arg0, 9, b"IPHONE16", b"Iphone", b"Apple", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/22d9ba19-17c9-42b1-b990-e5030a09d399.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IPHONE16>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IPHONE16>>(v1);
    }

    // decompiled from Move bytecode v6
}

