module 0x1a4f80496f30a6dc3d29492119475110eedeef62cfcbc86404344f2ff68044a6::king {
    struct KING has drop {
        dummy_field: bool,
    }

    fun init(arg0: KING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KING>(arg0, 6, b"KING", b"Richard Petty", b"Richard Petty, nicknamed \"The King\", is an American former NASCAR driver who competed from 1958 to 1992 in the former NASCAR Grand National and Winston Cup Series is coming out of retirement to compete in Turbos Cup on Sui?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731559954608.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KING>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KING>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

