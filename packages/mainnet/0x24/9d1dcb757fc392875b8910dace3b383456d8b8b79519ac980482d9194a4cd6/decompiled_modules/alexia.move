module 0x249d1dcb757fc392875b8910dace3b383456d8b8b79519ac980482d9194a4cd6::alexia {
    struct ALEXIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALEXIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALEXIA>(arg0, 6, b"ALEXIA", b"Alexia Bonatsos", b"Celebrating Alexia Bonatsos, co-founder of Dream Machine and an investor in blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Alexia_Bonatsos_Coin_851ec5eaf8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALEXIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALEXIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

