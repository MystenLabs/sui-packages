module 0x9e6c590e79b4b60c4958f1d5a7e1c2f086fbfbf447bb396f3cc3d72bcb09fb11::kipli {
    struct KIPLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIPLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIPLI>(arg0, 6, b"KIPLI", b"KING KIPLI", b"kipli is the name they give to one of the plants in the plant vs zombie game", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732786266711.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIPLI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIPLI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

