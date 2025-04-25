module 0x68d11a1747f8cd8b9a42f503d1cb8d8af78f5d11a3bc64d85479c9cfc7d09eb5::ius {
    struct IUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: IUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IUS>(arg0, 9, b"IUS", b"INVERTED SUI", b"JUST A JOKE, MEME SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/d173c99d13266b5dc35c8042b5265548blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

