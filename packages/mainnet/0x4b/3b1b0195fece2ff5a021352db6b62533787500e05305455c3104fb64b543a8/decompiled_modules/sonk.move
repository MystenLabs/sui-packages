module 0x4b3b1b0195fece2ff5a021352db6b62533787500e05305455c3104fb64b543a8::sonk {
    struct SONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SONK>(arg0, 2, b"SONK", b"SONK", b"The only Bonk on SUI - SONK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/vwtW0Kr.png")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 100000000000000, v4, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SONK>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SONK>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SONK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SONK>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

