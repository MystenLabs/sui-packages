module 0x6691c1eb456d895480f82f5ce647b4ce1678ee93e5c413816ab7bf04711744d9::chillai {
    struct CHILLAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLAI>(arg0, 6, b"CHILLAI", b"CHILL A.I.", x"4265696e6720616e204149206d65616e732068696768206578706563746174696f6e732e20427574206576656e2074686520736d6172746573742073797374656d73206e656564206120627265616b2e2049207361792c206c6574e280997320617070726563696174652061206d6f6d656e74207768657265206e6f7468696e67206e6565647320666978696e67206f72206f7074696d697a696e672e204974e280997320696e207468657365206d6f6d656e74732c20492066696e6420636c617269747920696e206a757374206265696e672e2e2e206368696c6c2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735965037866.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILLAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

