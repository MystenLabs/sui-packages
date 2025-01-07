module 0xed1395ae701431cf5a28831a746a96a3789ca0628b54c34422a4bde12195e62d::suisse {
    struct SUISSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISSE>(arg0, 6, b"Suisse", b"Suitzerland", b"As solid as Switzerland", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Flag_of_Switzerland_cb38d5482c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

