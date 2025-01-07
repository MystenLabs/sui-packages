module 0x9094612856af817aeac9914637e78756eb7fbfb60621a02039f773505bfe58f1::suisenk {
    struct SUISENK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISENK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISENK>(arg0, 6, b"SUISENK", b"SUI SENK", b"Coolest seal on senk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3009_86b97d74b6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISENK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISENK>>(v1);
    }

    // decompiled from Move bytecode v6
}

