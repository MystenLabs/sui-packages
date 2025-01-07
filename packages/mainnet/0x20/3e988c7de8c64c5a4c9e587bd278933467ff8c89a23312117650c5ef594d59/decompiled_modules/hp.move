module 0x203e988c7de8c64c5a4c9e587bd278933467ff8c89a23312117650c5ef594d59::hp {
    struct HP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HP>(arg0, 9, b"HP", b"HolyPrinter", x"4d61792074686520486f6c79205072696e74657220626c65737320616c6c206f6620796f757220626167732e20f09f9887f09f96a8efb88f2024485020697320746865206f6e65207472756520736f75726365206f6620616c6c20677265656e2063616e646c65732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/2Afz4qZZsjjBUeEWR4222Gk1CLBH3rtBbR3ortzbpump.png?size=lg&key=27c684")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HP>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HP>>(v1);
    }

    // decompiled from Move bytecode v6
}

