module 0xd0478ee3720011d954b6e8f08d1600a9dfffd546fece862dc5abf4700b6e1dc3::russianwif {
    struct RUSSIANWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUSSIANWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUSSIANWIF>(arg0, 6, b"RUSSIANWIF", b"Russian Dog Wif Hat", b"Cyka Blyat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/russiandogwif_f3d0e6a14f.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUSSIANWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUSSIANWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

