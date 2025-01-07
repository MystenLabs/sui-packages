module 0x54ed07b3b99a36e2b441206b78444e5099b581c13a5d2f52f540775293f557c2::usp {
    struct USP has drop {
        dummy_field: bool,
    }

    fun init(arg0: USP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USP>(arg0, 6, b"USP", b"USA PEPE", b"Never bet against the USA ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_20241013_172007_daaddeb6ca.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USP>>(v1);
    }

    // decompiled from Move bytecode v6
}

