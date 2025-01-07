module 0x8e976ce22f5c4b6906adb3788513bd8b5701ade1d8563b55c35c4f260754fa1d::jack {
    struct JACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: JACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JACK>(arg0, 6, b"JACK", b"HIJACKER", b"HIJACKER (JACK) is a new cryptocurrency inspired by the adventurous and rebellious spirit of legendary pirates. In the ever-evolving world of crypto, JACK emerges as a symbol of bravery and boundless exploration, offering unique features that set it apart from other digital currencies.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/Qma8WZQgYCfqpn9RQAQSuNHr6AUcT1Q5oLh6iSWSEpJfo5?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JACK>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JACK>>(v2, @0x57e6089b44d1da600898d94a72c796336936a40c8f73aef9da9c5e6af42c3b59);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

