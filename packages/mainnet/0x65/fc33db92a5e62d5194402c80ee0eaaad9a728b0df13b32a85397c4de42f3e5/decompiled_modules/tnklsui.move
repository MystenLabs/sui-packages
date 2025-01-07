module 0x65fc33db92a5e62d5194402c80ee0eaaad9a728b0df13b32a85397c4de42f3e5::tnklsui {
    struct TNKLSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TNKLSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TNKLSUI>(arg0, 6, b"TNKLSUI", b"TINKLE", b"The Sound of Water on Sui. Soon to be #1 Meme on Sui. Have a tinkle", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_15_153928278_70b9da88ff.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TNKLSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TNKLSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

