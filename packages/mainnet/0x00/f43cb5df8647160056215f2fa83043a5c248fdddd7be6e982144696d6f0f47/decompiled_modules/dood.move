module 0xf43cb5df8647160056215f2fa83043a5c248fdddd7be6e982144696d6f0f47::dood {
    struct DOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOOD>(arg0, 6, b"DOOD", b"Doods Sui", b"Memecoin on sui network, created by community and for the community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A_dbc39a8a23.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

