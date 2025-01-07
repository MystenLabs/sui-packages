module 0xbd038f8218fec97fde6f9569c456ae5dc2b541e8e42f9c957556f6f1a971474::st {
    struct ST has drop {
        dummy_field: bool,
    }

    fun init(arg0: ST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ST>(arg0, 6, b"ST", b"Suitember", b"Suitember isn't even close to over", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fsml_J_Yo_K_400x400_043f639acd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ST>>(v1);
    }

    // decompiled from Move bytecode v6
}

