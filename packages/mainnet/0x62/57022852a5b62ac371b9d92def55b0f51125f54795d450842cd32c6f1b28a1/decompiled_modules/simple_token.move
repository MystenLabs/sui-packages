module 0x6257022852a5b62ac371b9d92def55b0f51125f54795d450842cd32c6f1b28a1::simple_token {
    struct SIMPLE_TOKEN has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 9, b"SMPL", b"Simple Token", b"Simple Token showcases", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    fun init(arg0: SIMPLE_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<SIMPLE_TOKEN>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMPLE_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_and_consume_cap(arg0: 0x2::coin::TreasuryCap<SIMPLE_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SIMPLE_TOKEN>>(0x2::coin::mint<SIMPLE_TOKEN>(&mut arg0, arg1, arg3), arg2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMPLE_TOKEN>>(arg0, @0x0);
    }

    // decompiled from Move bytecode v6
}

