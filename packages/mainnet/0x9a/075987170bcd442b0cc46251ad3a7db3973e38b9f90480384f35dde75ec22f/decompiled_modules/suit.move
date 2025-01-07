module 0x9a075987170bcd442b0cc46251ad3a7db3973e38b9f90480384f35dde75ec22f::suit {
    struct SUIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIT>(arg0, 9, b"SUIT", b"Doge Wif Suit", b"STORY OF DOGE WIF SUIT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.zyrosite.com/cdn-cgi/image/format=auto,w=60,fit=crop,q=95/YleveDVNoDc9K2NG/group-1-copy-3-Aq2v21LJ3NCLoW9G.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

