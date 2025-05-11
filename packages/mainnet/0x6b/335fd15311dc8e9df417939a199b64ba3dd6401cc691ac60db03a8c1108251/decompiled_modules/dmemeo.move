module 0x6b335fd15311dc8e9df417939a199b64ba3dd6401cc691ac60db03a8c1108251::dmemeo {
    struct DMEMEO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DMEMEO>, arg1: 0x2::coin::Coin<DMEMEO>) {
        0x2::coin::burn<DMEMEO>(arg0, arg1);
    }

    fun init(arg0: DMEMEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMEMEO>(arg0, 2, b"DMEMEO", b"desmeme", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DMEMEO>>(v1);
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 100000000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMEMEO>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DMEMEO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DMEMEO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

