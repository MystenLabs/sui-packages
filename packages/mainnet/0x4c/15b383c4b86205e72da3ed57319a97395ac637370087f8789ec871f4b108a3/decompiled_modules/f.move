module 0x4c15b383c4b86205e72da3ed57319a97395ac637370087f8789ec871f4b108a3::f {
    struct F has drop {
        dummy_field: bool,
    }

    fun init(arg0: F, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<F>(arg0, 9, b"F", b"fsaDS", b"GS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0113c48f-64e0-4b0e-9eaa-96dc5f22af34.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<F>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<F>>(v1);
    }

    // decompiled from Move bytecode v6
}

