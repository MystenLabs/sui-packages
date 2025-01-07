module 0xb273a380ea3baf7b01fde9e436af916639a02081befa2e775aaa3012a4633152::pichu {
    struct PICHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PICHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PICHU>(arg0, 8, b"PICHU", b"PICHU", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.pokemon.com/assets/cms2/img/pokedex/detail/172.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PICHU>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PICHU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PICHU>>(v1);
    }

    // decompiled from Move bytecode v6
}

