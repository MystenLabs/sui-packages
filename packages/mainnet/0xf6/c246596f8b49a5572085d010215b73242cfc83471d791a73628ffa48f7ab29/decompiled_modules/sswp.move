module 0xf6c246596f8b49a5572085d010215b73242cfc83471d791a73628ffa48f7ab29::sswp {
    struct SSWP has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SSWP>, arg1: 0x2::coin::Coin<SSWP>) {
        0x2::coin::burn<SSWP>(arg0, arg1);
    }

    fun init(arg0: SSWP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSWP>(arg0, 9, b"SSWP", b"SSWP", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://crew3-production.s3.eu-west-3.amazonaws.com/public/7528122b-63c7-415e-aa02-9c122d3a77a7-profile.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSWP>>(v1);
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 500000000000000000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSWP>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SSWP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SSWP>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

