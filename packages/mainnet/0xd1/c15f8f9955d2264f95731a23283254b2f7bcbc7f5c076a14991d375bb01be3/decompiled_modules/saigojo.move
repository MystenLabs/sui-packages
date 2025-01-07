module 0xd1c15f8f9955d2264f95731a23283254b2f7bcbc7f5c076a14991d375bb01be3::saigojo {
    struct SAIGOJO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAIGOJO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAIGOJO>(arg0, 9, b"SAIGOJO", b"Gojo", b"Just try it....plz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/96227407-0c0d-43b8-a284-8aa41c8e264b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAIGOJO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAIGOJO>>(v1);
    }

    // decompiled from Move bytecode v6
}

