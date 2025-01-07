module 0x101856c96f49733e78bcc37c4fa03bdaaadf39cb7e5341371eeb5231c968e20a::sape {
    struct SAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAPE>(arg0, 6, b"SAPE", b"SuiAPE meme token", b"Meme Token for SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SAPE_a9345324ca.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

