module 0xe5acc2d53868238ccb80f4506fc4528b02e9b30003162f36023cff7de9394367::gos {
    struct GOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOS>(arg0, 6, b"GOS", b"Game Of Sui", b"Valar morghulis \"All memecoins must die\" We want to climb the iron throne. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_16_04_44_46_6ac959f03d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

