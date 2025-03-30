module 0xcf3af706dfb27b02a78cf2c7ffab070be0644a1327ec1e13237498052edadb84::flm {
    struct FLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLM>(arg0, 9, b"FLM", b"Followme", b"Follow me into a bright future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/6503a2a0bc15d8cf0f344804b9c6c9a7blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

