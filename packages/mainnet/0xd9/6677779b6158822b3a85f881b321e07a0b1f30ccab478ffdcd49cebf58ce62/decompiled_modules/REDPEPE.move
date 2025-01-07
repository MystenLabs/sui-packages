module 0xd96677779b6158822b3a85f881b321e07a0b1f30ccab478ffdcd49cebf58ce62::REDPEPE {
    struct REDPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: REDPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REDPEPE>(arg0, 9, b"RED PEPE", b"REDPEPE", b"Pepe was bearish on crypto, SUI has show PEPE the GREEN light", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/KtfYPk9.jpeg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REDPEPE>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<REDPEPE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REDPEPE>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

