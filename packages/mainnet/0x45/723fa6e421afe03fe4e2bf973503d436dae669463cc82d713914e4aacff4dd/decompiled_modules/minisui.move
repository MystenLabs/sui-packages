module 0x45723fa6e421afe03fe4e2bf973503d436dae669463cc82d713914e4aacff4dd::minisui {
    struct MINISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINISUI>(arg0, 6, b"MINISUI", b"MINISUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ibb.co/bsGJM6w"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MINISUI>>(v1);
        0x2::coin::mint_and_transfer<MINISUI>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MINISUI>>(v2);
    }

    // decompiled from Move bytecode v6
}

