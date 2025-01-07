module 0xf8d343d91b5856af4940de53d217f28b82122ca935d148e8a245d616e007bb31::scihub {
    struct SCIHUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCIHUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCIHUB>(arg0, 6, b"SCIHUB", b"scihub", b"Sci-Hub is the most controversial project in today science. The goal of Sci-Hub is to provide free and unrestricted access to all scientific knowledge ever published in journal or book form.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731850222421.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCIHUB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCIHUB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

