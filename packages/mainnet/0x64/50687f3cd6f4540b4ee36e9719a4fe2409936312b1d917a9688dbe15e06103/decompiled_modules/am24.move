module 0x6450687f3cd6f4540b4ee36e9719a4fe2409936312b1d917a9688dbe15e06103::am24 {
    struct AM24 has drop {
        dummy_field: bool,
    }

    fun init(arg0: AM24, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AM24>(arg0, 9, b"AM24", b"America 24", b"This is the token of the Americas Presidential election.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/47639f96-b6c1-4662-b5f5-d4a0f97ecb1d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AM24>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AM24>>(v1);
    }

    // decompiled from Move bytecode v6
}

