module 0x10bd32b3fdfbadf682447d7d4052b5fa6b55bcde47bde25d7657b32aea671ba4::standard_a30 {
    struct STANDARD_A30 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<STANDARD_A30>, arg1: 0x2::coin::Coin<STANDARD_A30>) {
        0x2::coin::burn<STANDARD_A30>(arg0, arg1);
    }

    public fun execute(arg0: &mut 0x2::coin::TreasuryCap<STANDARD_A30>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<STANDARD_A30> {
        0x2::coin::mint<STANDARD_A30>(arg0, arg1, arg2)
    }

    public entry fun execute_to(arg0: &mut 0x2::coin::TreasuryCap<STANDARD_A30>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<STANDARD_A30>>(0x2::coin::mint<STANDARD_A30>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: STANDARD_A30, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STANDARD_A30>(arg0, 9, b"NAVX", b"NAVX Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-sTOWutPSN8.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<STANDARD_A30>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STANDARD_A30>>(v1);
    }

    public fun protocol_id() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

