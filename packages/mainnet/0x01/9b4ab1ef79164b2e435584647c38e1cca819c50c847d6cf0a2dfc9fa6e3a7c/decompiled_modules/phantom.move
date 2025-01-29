module 0x19b4ab1ef79164b2e435584647c38e1cca819c50c847d6cf0a2dfc9fa6e3a7c::phantom {
    struct PHANTOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHANTOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHANTOM>(arg0, 6, b"PHANTOM", b"Nigga Phantom", b"Phantom bringing that swinging BBC to get all the Sui pussies wet like the chain they are on", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_01_30_00_04_59_8e3f6b3425.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHANTOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PHANTOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

