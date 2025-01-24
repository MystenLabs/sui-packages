module 0x55ced74995745f0990152a5df4a51fea647b4f05c524b5b529870d9b9e646360::muzic {
    struct MUZIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUZIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUZIC>(arg0, 6, b"MUZIC", b"MUZIC", b"MUZIC ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.artistfirst.in/uploads/1737713847233-muzic.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUZIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MUZIC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

