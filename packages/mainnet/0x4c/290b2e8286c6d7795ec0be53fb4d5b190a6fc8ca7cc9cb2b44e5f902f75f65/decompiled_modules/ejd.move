module 0x4c290b2e8286c6d7795ec0be53fb4d5b190a6fc8ca7cc9cb2b44e5f902f75f65::ejd {
    struct EJD has drop {
        dummy_field: bool,
    }

    fun init(arg0: EJD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EJD>(arg0, 6, b"Ejd", b"Dont buy testing ", b"Join telegram for ofc launch of superleague - https://t.me/superleague_sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1748848574009.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EJD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EJD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

