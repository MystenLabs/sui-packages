module 0x524b72be03934654d54df1c0afd3c6f687de534a6aeb6a2421a634a0ad0bd932::ele {
    struct ELE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELE>(arg0, 6, b"ELE", b"ElephantOnSui", x"454c455048414e542069732066756c6c7920646563656e7472616c697a656420616e64206f776e65640a6279206974732066756e20616e642076696272616e7420636f6d6d756e6974792e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000163_388ff9a847.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELE>>(v1);
    }

    // decompiled from Move bytecode v6
}

