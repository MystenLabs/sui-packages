module 0x213f2fbe184b666075be64b9225c3a423cd58b9f028a9eff32baa15a8bd1803a::suizombie {
    struct SUIZOMBIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZOMBIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZOMBIE>(arg0, 9, b"Suizombie", b"zombie", x"63616ec2b474206469652e2e2e2e7375692077696c6c206c69766520666f7265766572", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/608a8bbe5fff0a00c12cb08aeade67e5blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIZOMBIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZOMBIE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

