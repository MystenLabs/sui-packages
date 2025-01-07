module 0x6b00c5178fff5fe2f080e7f60f20d9e882dd8de4451ad482ea048c4b4a96aa65::caon {
    struct CAON has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAON>(arg0, 6, b"CAON", b"carrion", b"carrion!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Diseno_sin_titulo_2_4efb50009c_c6f7b1417c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAON>>(v1);
    }

    // decompiled from Move bytecode v6
}

