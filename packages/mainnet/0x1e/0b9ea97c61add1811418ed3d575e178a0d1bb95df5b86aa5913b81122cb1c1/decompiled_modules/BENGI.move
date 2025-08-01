module 0x1e0b9ea97c61add1811418ed3d575e178a0d1bb95df5b86aa5913b81122cb1c1::BENGI {
    struct BENGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENGI>(arg0, 6, b"Bengillions", b"Bengi", b"you cant beat the king of crypto.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"blob:https://mfc.club/8085f2b7-24e5-4d4f-9efa-6d7206ac4c10")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENGI>>(v0, @0x2c478b5f158e037cb21b3443a5a3512f6fee0b9a16d7a261baa00ddca69d6fc5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BENGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

