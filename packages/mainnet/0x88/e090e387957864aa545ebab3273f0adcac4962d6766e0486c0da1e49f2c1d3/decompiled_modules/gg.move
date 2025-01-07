module 0x88e090e387957864aa545ebab3273f0adcac4962d6766e0486c0da1e49f2c1d3::gg {
    struct GG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GG>(arg0, 9, b"GG", b"Giga", b"Strong man", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/62254dfb-6d4f-4ff1-9047-c30877bce4b7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GG>>(v1);
    }

    // decompiled from Move bytecode v6
}

