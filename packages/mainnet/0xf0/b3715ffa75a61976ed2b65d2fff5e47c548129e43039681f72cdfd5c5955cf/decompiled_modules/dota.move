module 0xf0b3715ffa75a61976ed2b65d2fff5e47c548129e43039681f72cdfd5c5955cf::dota {
    struct DOTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOTA>(arg0, 9, b"DOTA", b"DOTA", b"DOTA Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOTA>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOTA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

