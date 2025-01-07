module 0x39657b9a5f62f70f6562237c593ec62f3e009aa78c409fd21f3f13742833f102::ratasui {
    struct RATASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RATASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RATASUI>(arg0, 6, b"RATASUI", b"RataSui of SUI", b"RataSui \"The CHEF of Sui Chain\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ratasui_5c6389f9ec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RATASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RATASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

