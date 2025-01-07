module 0x4aaa2099ccb952833c1f74e71e8dae3b19ebb59b62bc6437efa371395d8d1aba::cepybala {
    struct CEPYBALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CEPYBALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CEPYBALA>(arg0, 6, b"CEPYBALA", b"CEPYBALA SUIBALA", b"We are the next top meme on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241011_235327_7060a92a75.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CEPYBALA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CEPYBALA>>(v1);
    }

    // decompiled from Move bytecode v6
}

