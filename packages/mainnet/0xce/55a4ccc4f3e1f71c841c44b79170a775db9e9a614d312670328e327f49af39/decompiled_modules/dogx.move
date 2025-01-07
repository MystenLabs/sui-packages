module 0xce55a4ccc4f3e1f71c841c44b79170a775db9e9a614d312670328e327f49af39::dogx {
    struct DOGX has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGX>(arg0, 6, b"DOGX", b"DOGE FUN", b"memcoin on Sui Ntwork", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DOGX_ea3e7f3e32.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGX>>(v1);
    }

    // decompiled from Move bytecode v6
}

