module 0x597d79c7aee93fd386d6632332b87939647d78934a5ca862da7c73a7ea6c0190::gorklon {
    struct GORKLON has drop {
        dummy_field: bool,
    }

    fun init(arg0: GORKLON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GORKLON>(arg0, 9, b"gorklon", b"gorklon rust", b"Inspired by Elon Musk changed his X name to gorklon rust", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/tsYizAv.jpeg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GORKLON>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GORKLON>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GORKLON>>(v2);
    }

    // decompiled from Move bytecode v6
}

