module 0x6055748e4cbeb1865229808dfa7d01f937969c7a060dde4b4b987fdf021b60d3::shu {
    struct SHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHU>(arg0, 9, b"Shu", b"Shushi", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHU>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHU>>(v1);
    }

    // decompiled from Move bytecode v6
}

