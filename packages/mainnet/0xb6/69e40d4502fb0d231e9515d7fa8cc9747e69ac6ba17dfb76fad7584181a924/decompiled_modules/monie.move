module 0xb669e40d4502fb0d231e9515d7fa8cc9747e69ac6ba17dfb76fad7584181a924::monie {
    struct MONIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONIE>(arg0, 6, b"MONIE", b"Sui Monie", b"The New Face of Global Currency", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_300x271_8cc69be1e2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

