module 0xac06b6432d91658d51fae2b12d035a72912cd2f258054ca8732127b8ac4c5503::ttt {
    struct TTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTT>(arg0, 6, b"TTT", b"Token T", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/58b7b7af-7240-4016-a6f9-5f52092f46cb.webp")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TTT>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

