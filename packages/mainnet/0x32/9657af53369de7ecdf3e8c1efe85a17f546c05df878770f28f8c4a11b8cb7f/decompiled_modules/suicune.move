module 0x329657af53369de7ecdf3e8c1efe85a17f546c05df878770f28f8c4a11b8cb7f::suicune {
    struct SUICUNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICUNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICUNE>(arg0, 9, b"$SUICUNE", b"Suicune", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/ppsvwhB.png"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUICUNE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUICUNE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICUNE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

