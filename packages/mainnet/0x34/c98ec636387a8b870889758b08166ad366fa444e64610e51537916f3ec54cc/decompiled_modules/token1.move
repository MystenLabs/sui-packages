module 0x34c98ec636387a8b870889758b08166ad366fa444e64610e51537916f3ec54cc::token1 {
    struct TOKEN1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN1>(arg0, 9, b"TOKEN1", b"Token DEmo 01", b"none", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e75588a6ecde268eaaa5f60cd08d8c8eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

