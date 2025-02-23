module 0x1cfdedbbebc37ff535ad4e8975a24ea5532e0c556407f9945b285cf4873cd556::tekko {
    struct TEKKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEKKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEKKO>(arg0, 6, b"TEKKO", b"TEKKOONSUI", b"\"A person wearing a pest control uniform, carrying a mousetrap, walking on a city street at night, street lights shining, realistic style.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_955d9f051f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEKKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEKKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

