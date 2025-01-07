module 0x764e40831490532cff29c11039ff0a58ed1c037231e474ae66989efd2fc3450a::pod {
    struct POD has drop {
        dummy_field: bool,
    }

    fun init(arg0: POD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POD>(arg0, 6, b"POD", b"Portal Of Destiny", x"57656c636f6d6520746f20506f7274616c206f662044657374696e79202824504f442921200a496e206120776f726c642066756c6c206f6620616476656e74757265732c207468652041492052616e6765727320756e69746520746f20666967687420616761696e7374206576696c206d6f6e7374657273207468617420746872656174656e2070656163652e204a6f696e2074686973206578636974696e6720626174746c6520616e642070726f766520796f7572206272617665727920696e207468697320696e6e6f76617469766520706c617920746f206561726e2067616d6521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_token_9cb259a5ef.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POD>>(v1);
    }

    // decompiled from Move bytecode v6
}

