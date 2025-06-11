module 0xce3ce62cfcadcbe87f6503dc8f1e4ca5191e934e07c55736792c5b4aac920395::pgg {
    struct PGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PGG>(arg0, 6, b"PGG", b"Pokemon Go Game", x"506f6b656d6f6e20476f206973206120736d61727470686f6e652067616d65207468617420757365732047505320746563686e6f6c6f677920616e64204175676d656e746564205265616c69747920746f20636174636820616e6420747261696e20506f6bc3a96d6f6e2063686172616374657273207768696c6520706c6179657273206578706c6f726520746865207265616c20776f726c642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifx6bra7e2wd77rimntvxctkm3xcst73wn55hlnl57j5ujt2plnja")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PGG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

