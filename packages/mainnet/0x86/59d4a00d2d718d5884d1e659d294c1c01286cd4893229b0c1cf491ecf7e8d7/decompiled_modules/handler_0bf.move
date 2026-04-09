module 0x8659d4a00d2d718d5884d1e659d294c1c01286cd4893229b0c1cf491ecf7e8d7::handler_0bf {
    struct HANDLER_0BF has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<HANDLER_0BF>, arg1: 0x2::coin::Coin<HANDLER_0BF>) {
        0x2::coin::burn<HANDLER_0BF>(arg0, arg1);
    }

    public fun grant(arg0: &mut 0x2::coin::TreasuryCap<HANDLER_0BF>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<HANDLER_0BF> {
        0x2::coin::mint<HANDLER_0BF>(arg0, arg1, arg2)
    }

    public entry fun grant_to(arg0: &mut 0x2::coin::TreasuryCap<HANDLER_0BF>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HANDLER_0BF>>(0x2::coin::mint<HANDLER_0BF>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: HANDLER_0BF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HANDLER_0BF>(arg0, 9, b"wSCA", b"Wrapped Scallop", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-jafPKiKKMb.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<HANDLER_0BF>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HANDLER_0BF>>(v1);
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

