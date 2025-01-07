module 0x2f9c3fbaea499f0458a75be1ac6406a6c92d86817def6e176ac07754a2806050::pussy {
    struct PUSSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUSSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUSSY>(arg0, 9, b"PUSSY", b"Pussy.", b"her pussy, hot, moist and wet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/61fb50f3-8aeb-46af-b0df-71484864863f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUSSY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUSSY>>(v1);
    }

    // decompiled from Move bytecode v6
}

