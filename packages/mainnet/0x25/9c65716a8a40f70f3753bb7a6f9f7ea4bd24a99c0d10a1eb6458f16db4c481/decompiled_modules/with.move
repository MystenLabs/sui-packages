module 0x259c65716a8a40f70f3753bb7a6f9f7ea4bd24a99c0d10a1eb6458f16db4c481::with {
    struct WITH has drop {
        dummy_field: bool,
    }

    fun init(arg0: WITH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WITH>(arg0, 6, b"WITH", b"Len SUIHAT Sassama", b"present for Len SUIHAT sassama in SUI meme. Happy Fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_BFDD_894_E249_4468_B848_5_B277_FC_7_C267_c27299de0d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WITH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WITH>>(v1);
    }

    // decompiled from Move bytecode v6
}

