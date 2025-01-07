module 0x1d7bbe33acbcb7aaf9336cf04ef446a172b0d3f090c71c3c7b5c9b5172500830::sfock {
    struct SFOCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFOCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFOCK>(arg0, 6, b"Sfock", b"fock", x"466f636b20616c6c0a0a5765206865726521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_02_27_210500_813a5da223.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFOCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFOCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

