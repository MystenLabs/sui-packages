module 0xde401f842133f95da2e1670f4c3014db2fe2203162b70dbf97f40c4ca17d9bdf::am24 {
    struct AM24 has drop {
        dummy_field: bool,
    }

    fun init(arg0: AM24, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AM24>(arg0, 9, b"AM24", b"America 24", b"This is the token of the Americas Presidential election.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3fcff0a0-8c94-4930-ab53-860620b256de.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AM24>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AM24>>(v1);
    }

    // decompiled from Move bytecode v6
}

