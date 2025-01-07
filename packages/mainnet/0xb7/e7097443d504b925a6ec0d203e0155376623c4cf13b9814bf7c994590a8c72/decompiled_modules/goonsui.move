module 0xb7e7097443d504b925a6ec0d203e0155376623c4cf13b9814bf7c994590a8c72::goonsui {
    struct GOONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOONSUI>(arg0, 6, b"GOONSUI", b"GOON AI SUI", b"click on the goon button and generate images of your favorite character to start gooning!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_14_184317999_0e413c0762.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

