module 0x156dd837c676c0f1d6a9ec6f9d60befb66cab9668eecdc620d3f556008195b4::am24 {
    struct AM24 has drop {
        dummy_field: bool,
    }

    fun init(arg0: AM24, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AM24>(arg0, 9, b"AM24", b"America 24", b"America's Presidential election ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e616cd99-234c-49e3-ba85-a823d331d3dc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AM24>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AM24>>(v1);
    }

    // decompiled from Move bytecode v6
}

