module 0x81588ad51fa62ee0dedb24fbf7bd38874b54cadb8f58c47d0004a309431cd0e9::rizzmas {
    struct RIZZMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIZZMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIZZMAS>(arg0, 6, b"RIZZMAS", b"RIZZMAS COIN ON SUI", b"Early Christmas coming on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_30_05_36_57_c38c4a4ccf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIZZMAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIZZMAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

