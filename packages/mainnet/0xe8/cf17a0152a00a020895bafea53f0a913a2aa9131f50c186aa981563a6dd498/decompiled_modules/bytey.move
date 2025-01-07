module 0xe8cf17a0152a00a020895bafea53f0a913a2aa9131f50c186aa981563a6dd498::bytey {
    struct BYTEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BYTEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BYTEY>(arg0, 6, b"Bytey", b"Bytey On Sui", b"Bytey and the dream of conquering the universe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_a01cf87a6c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BYTEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BYTEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

