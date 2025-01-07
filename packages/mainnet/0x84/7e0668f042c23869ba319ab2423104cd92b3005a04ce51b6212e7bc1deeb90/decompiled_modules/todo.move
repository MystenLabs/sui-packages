module 0x847e0668f042c23869ba319ab2423104cd92b3005a04ce51b6212e7bc1deeb90::todo {
    struct TODO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TODO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TODO>(arg0, 6, b"TODO", b"Sui Todo", b"I am todo, you are todo, we are $todo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016999_b64050f19d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TODO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TODO>>(v1);
    }

    // decompiled from Move bytecode v6
}

