module 0x7ca77131177ca09975a6fb0bf5f8d80fa00290824b4cb1150ef4e75a6f247fad::dodododo {
    struct DODODODO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DODODODO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DODODODO>(arg0, 9, b"DODODODO", x"f09fa6884261627920536861726b", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DODODODO>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DODODODO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DODODODO>>(v1);
    }

    // decompiled from Move bytecode v6
}

