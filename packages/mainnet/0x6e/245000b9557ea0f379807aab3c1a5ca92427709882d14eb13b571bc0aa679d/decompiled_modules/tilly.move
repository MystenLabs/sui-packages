module 0x6e245000b9557ea0f379807aab3c1a5ca92427709882d14eb13b571bc0aa679d::tilly {
    struct TILLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TILLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TILLY>(arg0, 9, b"Tilly", b"a16z AI Dog", b"Tilly is an AI dog created by the a16z VC firm, which funded Truth Terminal, also known as $GOAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/HuiVprCHCucHUb5bX6EXFJd7wuwvdASFzzge4ahXpump.png?size=xl&key=5b1708")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TILLY>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TILLY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TILLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

