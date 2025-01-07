module 0x88085f919f0ae81c2ea6afe39ba96da2fee5b2748cf1b8dfa17a1860b5c4dd1c::gg {
    struct GG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GG>(arg0, 9, b"GG", b"Gsga", b"Talks about how great men are", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ac4c365b-266f-439a-b102-c9141e2dab7a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GG>>(v1);
    }

    // decompiled from Move bytecode v6
}

