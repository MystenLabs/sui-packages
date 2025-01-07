module 0x83dc510d5aa099fd6c8df7d38c34cffc9bd8e828bf7cb3f0d22d8e2830ade7f::eto {
    struct ETO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETO>(arg0, 6, b"ETO", b"ETO Token", b"Earth-Trisolaris Organization", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/217e34c9faaa4e07945aeff225fd1b2e_24aeae2bd5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ETO>>(v1);
    }

    // decompiled from Move bytecode v6
}

