module 0x7b96a49752a04355715a08cf7d21047416af758c767a63f8febd0cac5f3f710f::suiwoof_token {
    struct SUIWOOF_TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIWOOF_TOKEN>, arg1: 0x2::coin::Coin<SUIWOOF_TOKEN>) {
        0x2::coin::burn<SUIWOOF_TOKEN>(arg0, arg1);
    }

    fun init(arg0: SUIWOOF_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWOOF_TOKEN>(arg0, 9, b"SWOOF", b"SUIWOOF", b"Woof Woof Woof !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://bafkreibkr2drhnne4opc6tnwinvm7rpefsnaxgli7mvcgcncdzuhzqlr2m.ipfs.nftstorage.link"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIWOOF_TOKEN>>(v1);
        0x2::coin::mint_and_transfer<SUIWOOF_TOKEN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIWOOF_TOKEN>>(v2);
    }

    // decompiled from Move bytecode v6
}

