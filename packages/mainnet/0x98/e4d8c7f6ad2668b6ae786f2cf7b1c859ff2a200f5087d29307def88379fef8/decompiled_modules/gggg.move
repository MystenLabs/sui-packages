module 0x98e4d8c7f6ad2668b6ae786f2cf7b1c859ff2a200f5087d29307def88379fef8::gggg {
    struct GGGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GGGG>(arg0, 9, b"gggg", b"gggg", b"gytfg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GGGG>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GGGG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GGGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

