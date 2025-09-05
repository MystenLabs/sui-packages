module 0x68377deee59a45de9b1087c4e08f103322d92bbd7420cb03df89a393eb60a623::pandu {
    struct PANDU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANDU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANDU>(arg0, 6, b"PANDU", b"Sui Pandas", b"Positive Energy & Good Vibes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/db2oWFPrrbTebhUB1QGr5_66jWehW92DT3W70Xxc2Jk")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PANDU>(&mut v2, 88888888888000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PANDU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANDU>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

