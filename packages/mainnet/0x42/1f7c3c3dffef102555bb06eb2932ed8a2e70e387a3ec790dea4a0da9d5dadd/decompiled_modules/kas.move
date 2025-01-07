module 0x421f7c3c3dffef102555bb06eb2932ed8a2e70e387a3ec790dea4a0da9d5dadd::kas {
    struct KAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAS>(arg0, 6, b"KAS", b"KASPA", b"KASPA BLOCKCHAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Kaspa_Icon_Dark_Green_glow_1f85f5251b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

