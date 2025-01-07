module 0xbb248e1aa5a2a98f3947d18be75fdb78b8f5488b10dd65b193c46a1a366b2944::wnavi {
    struct WNAVI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WNAVI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WNAVI>(arg0, 9, b"WNAVI", b"WNAVI Token", b"WNavi is One-stop Liquidity Protocol on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/FNGKLRGBS7D4lXxsmz4_F-xkMQs9DIRsTQT_q0Nn-iI")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WNAVI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WNAVI>>(v0, @0xce59f2a9fcbce27fee082a177af5d7cc4bc1609734e448debba73faaad5b4a30);
    }

    // decompiled from Move bytecode v6
}

