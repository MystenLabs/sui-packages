module 0x339ac2c9e45450538fc568ebc1ffd7b0b7350b1a523c6686c76e59aa561bc847::dog {
    struct DOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOG>(arg0, 6, b"DOG", b"d.o.g.e", x"48657265277320612066756e2074617267657420666f722068696768657220656475636174696f6e207265666f726d3a0a0a526576657273652074686520426964656e2061646d696e697374726174696f6e27732063686f69636520746f20737562736964697a6520746865206c656173742070726f647563746976652064656772656573207768696c652070656e616c697a696e672070656f706c6520666f72206d616a6f72696e6720696e2070726f64756374697665207375626a656374732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731465125481.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

