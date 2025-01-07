module 0xdfbb3d327c805b0d3dcdecb58c1d5cb6f3c96f17a62545d9eed52f2703da750a::hkt {
    struct HKT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HKT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HKT>(arg0, 9, b"HKT", b"HRE", b"new", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/11fb672e-af54-48b0-ada4-212a890fcfb7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HKT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HKT>>(v1);
    }

    // decompiled from Move bytecode v6
}

