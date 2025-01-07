module 0xa42f286c20cff24c4356a637cde5fbf664439c3db4700632532d7f37a1dad719::scammove {
    struct SCAMMOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAMMOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAMMOVE>(arg0, 6, b"ScamMove", b"Bluemove is a scam", b"BLUEMOVE IS A SCAM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_02_00_14_56_111c729185.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAMMOVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCAMMOVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

