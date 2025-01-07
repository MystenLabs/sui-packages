module 0xc611bd492c85f2eb2353f1fe7620f33dd1491c1bcb8a8aaf0c0dfd3f277e730::pepes {
    struct PEPES has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPES>(arg0, 6, b"PEPES", b"Pepe Sui", b"Pepe sui is the frist bridge to bring memes from ETH and BSC to SUI Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pepe_sui_4305fef32f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPES>>(v1);
    }

    // decompiled from Move bytecode v6
}

