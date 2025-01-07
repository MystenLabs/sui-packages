module 0x9b313828b1a6d514093c89b3a8cc986b320d3cad89415cfd941b851054b34f07::nat {
    struct NAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAT>(arg0, 9, b"NAT", b"natka", b"lovely cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://leopardus.pl/data/include/img/news/1689082690.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NAT>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

