module 0xa3f21bf36fc26dc9319b4a15dd497a00f8faf4a015697a69b4ee253432bb433::simple_token {
    struct SIMPLE_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIMPLE_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SIMPLE_TOKEN>(arg0, 9, b"MANAGED", b"MANAGED", b"Managed coin", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = v1;
        0x2::coin::mint_and_transfer<SIMPLE_TOKEN>(&mut v3, 1000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMPLE_TOKEN>>(v3, v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIMPLE_TOKEN>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SIMPLE_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SIMPLE_TOKEN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

