module 0xda908b2e95b48087c10efee6d623f827d4be0cdc2f5d7c90e28032955b25f22a::wifp {
    struct WIFP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIFP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIFP>(arg0, 9, b"WIFP", b"WIF PUDGY", b"literally just a pudgy wif a hat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmeJfaVh8yigxQC5ZpSFfLEgHpZkARuGeXNb8irS11h2eF")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WIFP>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIFP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIFP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

