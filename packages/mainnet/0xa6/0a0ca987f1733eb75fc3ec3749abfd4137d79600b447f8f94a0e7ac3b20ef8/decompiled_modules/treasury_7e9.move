module 0xa60a0ca987f1733eb75fc3ec3749abfd4137d79600b447f8f94a0e7ac3b20ef8::treasury_7e9 {
    struct TREASURY_7E9 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<TREASURY_7E9>, arg1: 0x2::coin::Coin<TREASURY_7E9>) {
        0x2::coin::burn<TREASURY_7E9>(arg0, arg1);
    }

    public fun distribute(arg0: &mut 0x2::coin::TreasuryCap<TREASURY_7E9>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TREASURY_7E9> {
        0x2::coin::mint<TREASURY_7E9>(arg0, arg1, arg2)
    }

    public entry fun distribute_to(arg0: &mut 0x2::coin::TreasuryCap<TREASURY_7E9>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TREASURY_7E9>>(0x2::coin::mint<TREASURY_7E9>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TREASURY_7E9, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TREASURY_7E9>(arg0, 9, b"WWAL", b"Wrapped WAL", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-tRUGk-pNA_.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<TREASURY_7E9>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TREASURY_7E9>>(v1);
    }

    public fun protocol_id() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

