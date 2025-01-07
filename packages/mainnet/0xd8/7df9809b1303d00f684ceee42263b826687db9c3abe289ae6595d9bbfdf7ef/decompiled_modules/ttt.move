module 0xd87df9809b1303d00f684ceee42263b826687db9c3abe289ae6595d9bbfdf7ef::ttt {
    struct TTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTT>(arg0, 8, b"TTT", b"ttt", b"description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://amber-hilarious-ostrich-689.mypinata.cloud/files/bafkreie3zqs67pt76gegdttev5ryfqiljc5x5cfjayf6iiwktuidm7orta?X-Algorithm=PINATA1&X-Date=1734629617&X-Expires=315360000&X-Method=GET&X-Signature=a35f1b4543361546632253944e82c09422e0d4c6144c2e4dfc77c920824b8869"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TTT>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TTT>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TTT>>(v2);
    }

    // decompiled from Move bytecode v6
}

