module 0xe9498c500c52a4c988c5acf02dd64723c357e756873ada8d692679e9745af5dd::lionwif {
    struct LIONWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIONWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIONWIF>(arg0, 9, b"Lionwif", b"Lionwifhat", b"its a lion with a cowboy hat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LIONWIF>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIONWIF>>(v2, @0xfa35f2a535d78a65e8d67cda3a7bcb07cf20c18d87f8f7459b8ae4257a7991d5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIONWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

