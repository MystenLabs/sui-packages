module 0x504564397089a5d7d3c508469b81a5abef5131b417d12827efa3cf21bd0c13bc::scallop_sca {
    struct SCALLOP_SCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALLOP_SCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALLOP_SCA>(arg0, 9, b"sSCA", b"sSCA", b"Scallop interest-bearing token for SCA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://57ubbiat4idplsazcdyxyj3dhensxvsj7m4g26kpcrtwy74g4nhq.arweave.net/7-gQoBPiBvXIGRDxfCdjORsr1kn7OG15TxRnbH-G408")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALLOP_SCA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALLOP_SCA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

