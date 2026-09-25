module 0x919e0242345da6079783599630ea0d24af46fa7c277133fdf030c6333f4e4c77::zzz {
    struct ZZZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZZZ>(arg0, 9, b"ZZZ", b"ZZZ", b"Blast", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://files.catbox.moe/4o249b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZZZ>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZZZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ZZZ>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ZZZ>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

