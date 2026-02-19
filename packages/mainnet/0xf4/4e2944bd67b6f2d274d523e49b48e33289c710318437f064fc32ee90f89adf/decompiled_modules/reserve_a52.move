module 0xf44e2944bd67b6f2d274d523e49b48e33289c710318437f064fc32ee90f89adf::reserve_a52 {
    struct RESERVE_A52 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<RESERVE_A52>, arg1: 0x2::coin::Coin<RESERVE_A52>) {
        0x2::coin::burn<RESERVE_A52>(arg0, arg1);
    }

    public fun handle(arg0: &mut 0x2::coin::TreasuryCap<RESERVE_A52>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<RESERVE_A52> {
        0x2::coin::mint<RESERVE_A52>(arg0, arg1, arg2)
    }

    public entry fun handle_to(arg0: &mut 0x2::coin::TreasuryCap<RESERVE_A52>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<RESERVE_A52>>(0x2::coin::mint<RESERVE_A52>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: RESERVE_A52, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RESERVE_A52>(arg0, 9, b"ALPHA", b"ALPHA Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-lzv3PMgNMj.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<RESERVE_A52>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RESERVE_A52>>(v1);
    }

    public fun protocol_id() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

