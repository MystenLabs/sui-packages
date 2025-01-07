module 0x3cb457729ffdd4b2b4032e2f88eb565914934b3b40d30fcc5caa6f1f28352aba::sho {
    struct SHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHO>(arg0, 9, b"Sho", b"Shonda", b"meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHO>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHO>>(v1);
    }

    // decompiled from Move bytecode v6
}

