module 0xafbd44e5c8869dfb698c36f5ad7a000bd787c704da82cfe042f591de54b7b55d::wanke {
    struct WANKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WANKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WANKE>(arg0, 6, b"WANKE", b"Wanke", b"Meet Wanke. The Retardiest one", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ls513_Uml_400x400_5277d549ff.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WANKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WANKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

