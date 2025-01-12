module 0xa594441b2d0babb862e73937af1a985997cdd1fa9360503ac564911cd579d67c::echox {
    struct ECHOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: ECHOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ECHOX>(arg0, 6, b"ECHOX", b"EchoX Runner", x"4563686f582052756e6e65723a205265766f6c7574696f6e697a696e672047616d696e67207769746820536f756e6420262052657761726473210a0a446576656c6f706564206279204563686f5820496e632c204563686f582052756e6e65722074616b65732067616d696e6720746f20746865206e657874206c6576656c206279206c657474696e6720796f7520636f6e74726f6c207468652067616d65207573696e6720796f757220736f756e64206465636962656c732e204469766520696e746f2074686520503245206d6f646520616e64206561726e204563686f582052756e6e657220546f6b656e7320617320796f7520706c6179", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736713605538.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ECHOX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ECHOX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

