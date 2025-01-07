module 0x39f9ebd40819454d0257360e49c713a006fd8cdcfcfe6ee34cafde6c41e93a96::eevee {
    struct EEVEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EEVEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EEVEE>(arg0, 2, b"EEVEE", b"EEVEE", b"EEVEE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.denofgeek.com/wp-content/uploads/2021/09/Eevee.png?fit=1920%2C1080")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 100000000, v4, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EEVEE>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<EEVEE>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<EEVEE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<EEVEE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

