module 0x1f3e42e1bc240cd34ebe2ebcc550aa71d0a3a4ca01f6d3197d09cf6aa93f82c4::zkiv {
    struct ZKIV has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZKIV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZKIV>(arg0, 6, b"ZKIV", b"zSUIkhive", x"245a4b484956452069732074686520666972737420646563656e7472616c697a6564204669726577616c6c20666f722063727970746f20706c6174666f726d732c20706f77657265642062792041492d617373697374656420666f726d616c20766572696669636174696f6e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bee000_5439fbb240.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZKIV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZKIV>>(v1);
    }

    // decompiled from Move bytecode v6
}

