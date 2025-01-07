module 0x54a5a9bb90ad2571b388179c7f4e20387667ceef4cad55a217d3f3c0801de10::menguin {
    struct MENGUIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MENGUIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MENGUIN>(arg0, 6, b"Menguin", b"Meow Penguin", b"Menguins are the result of crossbreeding between meows and penguins, a specialty of science.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732525399307.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MENGUIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MENGUIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

