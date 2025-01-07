module 0x4ff33e97e95963d902b58b192afc6e6dc044c79d9c76fb931213584b9d50e937::koaa {
    struct KOAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOAA>(arg0, 6, b"Koaa", b"dispel moi koaaaaaaa", b"koaaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/blaz_1fad30cf26.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

