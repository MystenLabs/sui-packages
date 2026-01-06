module 0x829d14739e263290dcef12d1594c049bb6d14afe56c47dbba5272e5137fabb37::yee {
    struct YEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: YEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YEE>(arg0, 9, b"YEE", b"YEE on SUI", b"After taking over Ethereum Yee finally arrives on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmTRNoMsJjuyrdRG1hRwL9YU3yAJZZWjyQr1oTHCpaYsQR")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<YEE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YEE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

