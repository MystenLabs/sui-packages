module 0x5801fa28294205a80586d6d23a4ea0529cd05aa5569b4d3629d0c556f3cbe39a::mushy {
    struct MUSHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSHY>(arg0, 6, b"MUSHY", b"Mushy on Sui", b"The clock on the wall started spinning backwards. Im not sure if Im late , early, or on time", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048051_c3e4579235.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSHY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUSHY>>(v1);
    }

    // decompiled from Move bytecode v6
}

