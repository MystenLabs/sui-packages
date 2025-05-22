module 0x5ef2729f82d46c59474bdc1ef356c8ec0da855144bab825c9342e53bb3f5f75a::dfddd {
    struct DFDDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFDDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFDDD>(arg0, 9, b"DFDDD", b"AAS", b"sfsdfsdf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dev-file-walletapp.waveonsui.com/images/wave-pumps/769f5cf2-1955-4399-ae66-d9b5855fbffd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFDDD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DFDDD>>(v1);
    }

    // decompiled from Move bytecode v6
}

