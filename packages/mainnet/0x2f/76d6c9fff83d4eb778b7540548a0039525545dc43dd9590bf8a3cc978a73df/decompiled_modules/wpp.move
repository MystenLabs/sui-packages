module 0x2f76d6c9fff83d4eb778b7540548a0039525545dc43dd9590bf8a3cc978a73df::wpp {
    struct WPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WPP>(arg0, 9, b"WPP", b"WEWEPUMP", x"4e617365656d203130306d6c0a5461696261200a44616e6920200a4c616971610a4a616d65656c610a4c616d73610a4275736872610a44616c697961200a417a6861720a4c6f76656c790a42757268616d0a59757372610a5361646174", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e516ab04-f031-4b0d-8385-aa9c0e0ccb89.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WPP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WPP>>(v1);
    }

    // decompiled from Move bytecode v6
}

