module 0xba06444cc2c369bd3774e488636cc1e94f4001f2c9f1a70a5c98d22210e7ed8a::bbgt {
    struct BBGT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBGT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBGT>(arg0, 9, b"BBGT", x"4261427920676f617420f09f9090e2808b", b"the best swap option in SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.google.es/imgres?q=goat%20png&imgurl=https%3A%2F%2Fwww.shutterstock.com%2Fimage-vector%2Fgoat-vector-png-illustration-silhouette-260nw-2312418387.jpg&imgrefurl=https%3A%2F%2Fwww.shutterstock.com%2Fes%2Fsearch%2Fgoats-png&docid=hUDijW2gmCaTSM&tbnid=yz1l56Qasbi6eM&vet=12ahUKEwi-2qCM4tSJAxXlU6QEHaB7EQsQM3oECBYQAA..i&w=260&h=280&hcb=2&ved=2ahUKEwi-2qCM4tSJAxXlU6QEHaB7EQsQM3oECBYQAA")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BBGT>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBGT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBGT>>(v1);
    }

    // decompiled from Move bytecode v6
}

