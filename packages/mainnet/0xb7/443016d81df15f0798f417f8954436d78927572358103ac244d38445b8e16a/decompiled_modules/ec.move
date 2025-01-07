module 0xb7443016d81df15f0798f417f8954436d78927572358103ac244d38445b8e16a::ec {
    struct EC has drop {
        dummy_field: bool,
    }

    fun init(arg0: EC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EC>(arg0, 9, b"EC", b"Echo Chain", b"EcoChain is a green cryptocurrency designed to promote sustainability and environmental projects. By rewarding eco-friendly initiatives, it empowers users to invest in a cleaner future while supporting innovations that protect our planet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3188db35-689d-41bc-9627-d88d4ef58263.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EC>>(v1);
    }

    // decompiled from Move bytecode v6
}

