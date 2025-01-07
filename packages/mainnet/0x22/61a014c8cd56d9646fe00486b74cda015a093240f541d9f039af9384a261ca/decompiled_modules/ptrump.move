module 0x2261a014c8cd56d9646fe00486b74cda015a093240f541d9f039af9384a261ca::ptrump {
    struct PTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTRUMP>(arg0, 6, b"PTrump", b"PeanutTrump", b"PeanutTrump  on Sui is here to range .. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ae_e_edd6a95b13.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

