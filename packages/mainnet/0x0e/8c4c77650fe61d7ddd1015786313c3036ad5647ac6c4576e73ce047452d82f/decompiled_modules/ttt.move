module 0xe8c4c77650fe61d7ddd1015786313c3036ad5647ac6c4576e73ce047452d82f::ttt {
    struct TTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTT>(arg0, 6, b"ttt", b"ttt", b"tttr", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TTT>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

