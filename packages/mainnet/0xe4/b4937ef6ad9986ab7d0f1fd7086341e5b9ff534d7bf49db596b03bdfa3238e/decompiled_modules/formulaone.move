module 0xe4b4937ef6ad9986ab7d0f1fd7086341e5b9ff534d7bf49db596b03bdfa3238e::formulaone {
    struct FORMULAONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FORMULAONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FORMULAONE>(arg0, 9, b"FORMULAONE", b"F1", x"526163696e67206c6567656e6420536f6e6e7920486179657320697320636f61786564206f7574206f66207265746972656d656e7420746f206c6561642061207374727567676c696e6720466f726d756c612031207465616de28094616e64206d656e746f72206120796f756e6720686f7473686f742064726976657220e280947768696c652063686173696e67206f6e65206d6f7265206368616e636520617420676c6f72792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://a1.moviepassblack.com/w3/assets/FORMULAONE.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FORMULAONE>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FORMULAONE>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FORMULAONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

