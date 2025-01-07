module 0x9ce1e9c0fbc24b96d5c4afceb0e01b463faf929291aa941d45c9712c6e1f773e::suno {
    struct SUNO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUNO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNO>(arg0, 6, b"SUNO", b"SuiUno On Sui", b"First card game project on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241007_015035_b3eedb8aac.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUNO>>(v1);
    }

    // decompiled from Move bytecode v6
}

