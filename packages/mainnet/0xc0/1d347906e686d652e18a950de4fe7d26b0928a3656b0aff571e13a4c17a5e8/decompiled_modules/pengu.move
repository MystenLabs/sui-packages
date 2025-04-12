module 0xc01d347906e686d652e18a950de4fe7d26b0928a3656b0aff571e13a4c17a5e8::pengu {
    struct PENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGU>(arg0, 6, b"PENGU", b"Pudgy Penguin", b"PENGU is the official coin of Pudgy Penguins.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/34466_Photoroom_67db315c48.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

