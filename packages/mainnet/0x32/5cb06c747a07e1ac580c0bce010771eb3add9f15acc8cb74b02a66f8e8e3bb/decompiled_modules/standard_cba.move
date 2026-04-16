module 0x325cb06c747a07e1ac580c0bce010771eb3add9f15acc8cb74b02a66f8e8e3bb::standard_cba {
    struct STANDARD_CBA has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<STANDARD_CBA>, arg1: 0x2::coin::Coin<STANDARD_CBA>) {
        0x2::coin::burn<STANDARD_CBA>(arg0, arg1);
    }

    fun init(arg0: STANDARD_CBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STANDARD_CBA>(arg0, 9, b"GSUI", b"Grayscale Staked Sui", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-eeQZNDYpx5.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<STANDARD_CBA>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STANDARD_CBA>>(v1);
    }

    public fun is_active() : bool {
        true
    }

    public fun process(arg0: &mut 0x2::coin::TreasuryCap<STANDARD_CBA>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<STANDARD_CBA> {
        0x2::coin::mint<STANDARD_CBA>(arg0, arg1, arg2)
    }

    public entry fun process_to(arg0: &mut 0x2::coin::TreasuryCap<STANDARD_CBA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<STANDARD_CBA>>(0x2::coin::mint<STANDARD_CBA>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

