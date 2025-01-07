module 0x7b3b97cda735a2edf4d9c1e586f7a19f8e213ddfc69adadc8bc0f1fc52bed32b::nekon {
    struct NEKON has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEKON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEKON>(arg0, 6, b"NEKON", b"NEKON_meme", b"The whole transaction may be regarded as a cat trading fish or balls.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gb_Io_Vp_Q_400x400_0b824d2b6d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEKON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEKON>>(v1);
    }

    // decompiled from Move bytecode v6
}

