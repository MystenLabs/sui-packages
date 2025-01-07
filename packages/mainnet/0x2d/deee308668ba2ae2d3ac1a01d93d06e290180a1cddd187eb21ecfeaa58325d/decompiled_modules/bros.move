module 0x2ddeee308668ba2ae2d3ac1a01d93d06e290180a1cddd187eb21ecfeaa58325d::bros {
    struct BROS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROS>(arg0, 6, b"BROS", b"SUIper Mario", b"Get ready to collect coins and power-ups in the crypto world with $BROS, the SUIper Mario of the SUI network, where every block breaks limits on the path to success!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_39_b17189e36a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BROS>>(v1);
    }

    // decompiled from Move bytecode v6
}

