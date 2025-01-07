module 0x48cfa16dcef0b1d5d4871a8f4ad6533c222b942a14a633476b0e2470cb989e0f::pigu {
    struct PIGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIGU>(arg0, 9, b"PIGU", b"PIGU", b"PIGU like a symbol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://t3.ftcdn.net/jpg/00/71/83/90/360_F_71839037_VgXffl3DgbC0g3EOuC4yYiLCwtr5HV1d.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PIGU>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIGU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

