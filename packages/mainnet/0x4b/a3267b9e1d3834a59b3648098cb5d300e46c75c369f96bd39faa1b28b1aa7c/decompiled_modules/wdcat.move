module 0x4ba3267b9e1d3834a59b3648098cb5d300e46c75c369f96bd39faa1b28b1aa7c::wdcat {
    struct WDCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WDCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WDCAT>(arg0, 6, b"WDCAT", b"wizard cat", b"The wizard cat will bring you good luck and happiness", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20241011133330_7b54084f4f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WDCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WDCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

