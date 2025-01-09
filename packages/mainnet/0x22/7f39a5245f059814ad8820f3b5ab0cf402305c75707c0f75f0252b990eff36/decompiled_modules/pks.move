module 0x227f39a5245f059814ad8820f3b5ab0cf402305c75707c0f75f0252b990eff36::pks {
    struct PKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PKS>(arg0, 6, b"PKS", b"POP KAT SUI", b"POP KAT SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D66r_L_Lpv_400x400_5a6a1a23b0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

