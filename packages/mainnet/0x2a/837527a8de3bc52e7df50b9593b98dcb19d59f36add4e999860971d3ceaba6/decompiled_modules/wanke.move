module 0x2a837527a8de3bc52e7df50b9593b98dcb19d59f36add4e999860971d3ceaba6::wanke {
    struct WANKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WANKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WANKE>(arg0, 6, b"WANKE", b"wanke", b"Meet Wanke. The Retardiest one", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000115514_26b6440add.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WANKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WANKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

