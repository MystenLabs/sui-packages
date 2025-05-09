module 0x425be5f46f5639ab7201dfde3b2ed837fc129c434f55677c9ba11b528a3214a::scallop_haedal {
    struct SCALLOP_HAEDAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALLOP_HAEDAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALLOP_HAEDAL>(arg0, 9, b"sHAEDAL", b"sHAEDAL", b"Scallop interest-bearing token for HAEDAL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://q76s3qvzu2yznw2aafbytbpjceqkisje26w4yg4ul5gdtpztojrq.arweave.net/h_0twrmmsZbbQAFDiYXpESCkSSTXrcwblF9MOb8zcmM")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALLOP_HAEDAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALLOP_HAEDAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

