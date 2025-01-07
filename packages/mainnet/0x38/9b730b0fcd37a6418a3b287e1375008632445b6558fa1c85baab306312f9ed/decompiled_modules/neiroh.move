module 0x389b730b0fcd37a6418a3b287e1375008632445b6558fa1c85baab306312f9ed::neiroh {
    struct NEIROH has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIROH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIROH>(arg0, 6, b"NEIROH", b"NEIRO WIF HAT ON SUI", b"Neiro wif hat on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_neiroh_c98c2e1618.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIROH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEIROH>>(v1);
    }

    // decompiled from Move bytecode v6
}

