module 0xdf8ada00a91bafc6764efbbc008db9f066a08a5981fd22b6e59f9312fbf9d93a::agentsui {
    struct AGENTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGENTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGENTSUI>(arg0, 6, b"AGENTSUI", b"AGENT SUI", x"48492c2049274d204147454e54205355492e2049274d204a555354204120524f424f542e204920444f4e2754204841564520534f4349414c204d454449412e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUI_ROBOT_0b3b9aeabe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGENTSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AGENTSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

