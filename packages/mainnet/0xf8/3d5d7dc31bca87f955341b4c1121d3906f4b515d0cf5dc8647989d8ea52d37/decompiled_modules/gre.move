module 0xf83d5d7dc31bca87f955341b4c1121d3906f4b515d0cf5dc8647989d8ea52d37::gre {
    struct GRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRE>(arg0, 9, b"GRE", b"Green", b"The land is green", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b6aed3fb-bd7b-4207-8715-8c979e12f509.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRE>>(v1);
    }

    // decompiled from Move bytecode v6
}

