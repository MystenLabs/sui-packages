module 0x10a13bdbf3ac38c435f0dd08cbb7d69247e71cd5db6e95fcd86a65fd357706a::boga {
    struct BOGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOGA>(arg0, 6, b"BOGA", b"BO GA", b"BOGA SHHHHHH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f8vxcp_SM_400x400_f3835ce00d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

