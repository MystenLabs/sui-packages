module 0x2120e56d5cf66eec26d52e494dd0767c76b719dc01ccefe869741170f512564e::gurmi {
    struct GURMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GURMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GURMI>(arg0, 6, b"GURMI", b"Gurmi On Sui", x"224775726d692069732061206d656d65206f6e2053756920626c6f636b636861696e2c206b6e6f776e20666f72206974732068756d6f726f7573206f7220766972616c20636f6e74656e742077697468696e207468652063727970746f20616e64204d454d4520636f6d6d756e6974792e220a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241008_193527_0523506f71.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GURMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GURMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

