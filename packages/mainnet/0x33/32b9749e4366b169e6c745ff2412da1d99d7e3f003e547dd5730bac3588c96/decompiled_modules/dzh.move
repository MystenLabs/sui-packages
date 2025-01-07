module 0x3332b9749e4366b169e6c745ff2412da1d99d7e3f003e547dd5730bac3588c96::dzh {
    struct DZH has drop {
        dummy_field: bool,
    }

    fun init(arg0: DZH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DZH>(arg0, 9, b"DZH", b"Dorzh", b"Good mem token. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2fa5e998-603d-4321-ba1d-ac2aad2444d3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DZH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DZH>>(v1);
    }

    // decompiled from Move bytecode v6
}

