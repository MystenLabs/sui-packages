module 0x7708d98652c4c6f31c5fa84d8c168a6bf41bd4a4ad2233506e361564c61be0a1::ttt {
    struct TTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTT>(arg0, 9, b"TTT", b"ttt", b"Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://amber-hilarious-ostrich-689.mypinata.cloud/files/bafkreie3zqs67pt76gegdttev5ryfqiljc5x5cfjayf6iiwktuidm7orta?X-Algorithm=PINATA1&X-Date=1734629349&X-Expires=315360000&X-Method=GET&X-Signature=a7aba6c0461813b1b85442d44ba7565585d09538b06375cf4b1c76d22b003ee5"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TTT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TTT>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TTT>>(v2);
    }

    // decompiled from Move bytecode v6
}

