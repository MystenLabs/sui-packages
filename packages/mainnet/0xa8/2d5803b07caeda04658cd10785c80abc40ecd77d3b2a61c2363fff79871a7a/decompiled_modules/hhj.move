module 0xa82d5803b07caeda04658cd10785c80abc40ecd77d3b2a61c2363fff79871a7a::hhj {
    struct HHJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: HHJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HHJ>(arg0, 9, b"HHJ", b"Ghh", b"Fhh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/af901c8d-7bdd-4dfd-8262-32536a112d26.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HHJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HHJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

