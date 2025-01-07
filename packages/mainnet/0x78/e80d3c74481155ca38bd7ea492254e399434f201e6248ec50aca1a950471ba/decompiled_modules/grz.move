module 0x78e80d3c74481155ca38bd7ea492254e399434f201e6248ec50aca1a950471ba::grz {
    struct GRZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRZ>(arg0, 9, b"GRZ", b"Gorillaz ", b"Gruu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0c8c6c6a-a091-46da-8a41-d3ef2152a71f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

