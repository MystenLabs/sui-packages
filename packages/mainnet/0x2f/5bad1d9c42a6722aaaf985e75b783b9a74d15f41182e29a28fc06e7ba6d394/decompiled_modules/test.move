module 0x2f5bad1d9c42a6722aaaf985e75b783b9a74d15f41182e29a28fc06e7ba6d394::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TEST>(arg0, 6, b"TEST", b"test by SuiAI", b"D0 not buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/orca_AI_icon_for_crypto_ac624827a6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEST>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

