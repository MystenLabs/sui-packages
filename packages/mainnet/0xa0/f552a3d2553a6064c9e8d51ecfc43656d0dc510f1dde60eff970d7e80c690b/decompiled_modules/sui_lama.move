module 0xa0f552a3d2553a6064c9e8d51ecfc43656d0dc510f1dde60eff970d7e80c690b::sui_lama {
    struct SUI_LAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_LAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_LAMA>(arg0, 9, b"SUI LAMA", x"f09fa699537569204c616d61", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI_LAMA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_LAMA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI_LAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

