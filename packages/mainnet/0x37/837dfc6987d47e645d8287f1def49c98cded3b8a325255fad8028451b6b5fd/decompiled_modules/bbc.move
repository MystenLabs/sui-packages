module 0x37837dfc6987d47e645d8287f1def49c98cded3b8a325255fad8028451b6b5fd::bbc {
    struct BBC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBC>(arg0, 6, b"BBC", b"BBC", b"undefined", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"undefined"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBC>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BBC>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBC>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

