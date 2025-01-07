module 0xa9f24b8fef0b2ff979df596e587de71c5b5a649c389d05b01617ab3b104ab5ce::arn {
    struct ARN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARN>(arg0, 9, b"ARN", b"ARN", b"Hey Arnold!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRE4QEJtkNCMMgtRywU-uCB1LP0Qav1fpFCDw&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ARN>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARN>>(v1);
    }

    // decompiled from Move bytecode v6
}

