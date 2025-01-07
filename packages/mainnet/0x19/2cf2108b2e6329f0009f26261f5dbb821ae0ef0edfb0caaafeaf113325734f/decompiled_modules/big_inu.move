module 0x192cf2108b2e6329f0009f26261f5dbb821ae0ef0edfb0caaafeaf113325734f::big_inu {
    struct BIG_INU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIG_INU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIG_INU>(arg0, 9, b"BIG INU", b"INU INU", b"PUMP THIS TO THE MOON!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BIG_INU>(&mut v2, 3000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIG_INU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIG_INU>>(v1);
    }

    // decompiled from Move bytecode v6
}

