module 0x1f60f2f37fcb9290178e92458eb77446976dda63bbf2371498786e59bda1a0a6::krab {
    struct KRAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRAB>(arg0, 9, b"Krab", b"Krab", b"Krabster", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KRAB>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRAB>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KRAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

