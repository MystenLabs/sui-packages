module 0x59afee658db0f6167569947260bbbf81a17dd964c57e1d66dad098deefdc88f0::protocol_8f0 {
    struct PROTOCOL_8F0 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<PROTOCOL_8F0>, arg1: 0x2::coin::Coin<PROTOCOL_8F0>) {
        0x2::coin::burn<PROTOCOL_8F0>(arg0, arg1);
    }

    public fun generate(arg0: &mut 0x2::coin::TreasuryCap<PROTOCOL_8F0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<PROTOCOL_8F0> {
        0x2::coin::mint<PROTOCOL_8F0>(arg0, arg1, arg2)
    }

    public entry fun generate_to(arg0: &mut 0x2::coin::TreasuryCap<PROTOCOL_8F0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PROTOCOL_8F0>>(0x2::coin::mint<PROTOCOL_8F0>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PROTOCOL_8F0, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PROTOCOL_8F0>(arg0, 9, b"GSUI", b"Grayscale Staked Sui", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-eeQZNDYpx5.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<PROTOCOL_8F0>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PROTOCOL_8F0>>(v1);
    }

    public fun protocol_id() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

