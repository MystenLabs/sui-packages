module 0x2bb4174835e215651552674aa15f127b2a4e91c237743a468182dba4a99c6570::scm {
    struct SCM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCM>(arg0, 6, b"SCM", b"SCAM", b"100%SCAM or not?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732477637217.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

