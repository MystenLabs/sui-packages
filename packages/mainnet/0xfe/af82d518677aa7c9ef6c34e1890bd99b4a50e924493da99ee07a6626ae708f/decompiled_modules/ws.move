module 0xfeaf82d518677aa7c9ef6c34e1890bd99b4a50e924493da99ee07a6626ae708f::ws {
    struct WS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WS>(arg0, 9, b"WS", b"WS", b"WS - Launched on SuiLFG MemeFi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafkreigd6hufllapdcq6vvzg7rihb6rogxkt3xtgvuaexrjnk7yvpe3jbi")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

