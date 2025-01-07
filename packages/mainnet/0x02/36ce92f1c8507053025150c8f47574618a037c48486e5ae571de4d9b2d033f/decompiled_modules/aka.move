module 0x236ce92f1c8507053025150c8f47574618a037c48486e5ae571de4d9b2d033f::aka {
    struct AKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AKA>(arg0, 9, b"AKA", b"Akinia", b"Akinia to the world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be-alpha.7k.fun/api/file-upload/b11df319f6d44be8389f1e6934c63152blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AKA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

