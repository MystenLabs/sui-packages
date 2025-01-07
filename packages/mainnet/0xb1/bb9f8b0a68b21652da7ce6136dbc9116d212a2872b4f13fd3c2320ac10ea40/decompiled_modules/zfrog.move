module 0xb1bb9f8b0a68b21652da7ce6136dbc9116d212a2872b4f13fd3c2320ac10ea40::zfrog {
    struct ZFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZFROG>(arg0, 6, b"ZFROG", b"ZenFrogs", b"Lost in the multiverse", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/X3osy_Sbl_400x400_f8733dc548.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZFROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZFROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

