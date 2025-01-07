module 0xc987e01e17ac45416490693ba10b321f7b67d001f9304b052fe3f4f6d98ab6dd::soc {
    struct SOC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOC>(arg0, 6, b"SOC", b"Sui On Cat", b"First Cat On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUICATSUI_c203a3ccad.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOC>>(v1);
    }

    // decompiled from Move bytecode v6
}

