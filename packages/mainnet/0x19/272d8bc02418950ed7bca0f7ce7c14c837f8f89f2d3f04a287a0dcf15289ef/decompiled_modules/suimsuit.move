module 0x19272d8bc02418950ed7bca0f7ce7c14c837f8f89f2d3f04a287a0dcf15289ef::suimsuit {
    struct SUIMSUIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMSUIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMSUIT>(arg0, 6, b"SUIMSUIT", b"SUIm SUIt", b"Summer ready? Grab your SUIm SUIt and let's dive into the pool full of SUImmers!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001928_1fe8fdeb32.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMSUIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMSUIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

