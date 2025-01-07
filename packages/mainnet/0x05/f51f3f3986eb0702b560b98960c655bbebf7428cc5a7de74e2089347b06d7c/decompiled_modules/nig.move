module 0x5f51f3f3986eb0702b560b98960c655bbebf7428cc5a7de74e2089347b06d7c::nig {
    struct NIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIG>(arg0, 9, b"NIG", b"NIGG", b"NI GG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/db1c26af-bb5a-40ed-be86-a3344e508ea2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

