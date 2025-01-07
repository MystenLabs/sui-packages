module 0x9f9a4ea33165d1804e76c39643941529297c294ef59e7e71ca8b5cf5f9ed924d::westyinu {
    struct WESTYINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: WESTYINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WESTYINU>(arg0, 6, b"WESTYINU", b"WestyInu", x"576573747920496e75206272696e67732068697320636861726d696e6720616e642066756e207761797320746f20676574207468726f7567682074686520636f6d7065746974696f6e207768696c65206272696e67696e6720676f6f64206c75636b20616e6420666f7274756e6520746f2069747320686f6c646572732e0a4a6f696e20757320696e206f757220636f6d6d756e69747920616e64207465616d20626173656420746f6b656e20746861742077696c6c207075736820757320696e746f2074686520746f70206d656d6520636f696e73206f6620323032342e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1722720947269_f121d135f39f03e48da5fe5e8ced5b0a_387fa499dd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WESTYINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WESTYINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

