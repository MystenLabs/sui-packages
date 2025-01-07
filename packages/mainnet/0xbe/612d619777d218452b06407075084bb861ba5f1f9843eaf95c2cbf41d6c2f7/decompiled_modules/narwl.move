module 0xbe612d619777d218452b06407075084bb861ba5f1f9843eaf95c2cbf41d6c2f7::narwl {
    struct NARWL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NARWL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NARWL>(arg0, 6, b"NARWL", b"Narwhal Consensus", b"The unique representation of the innovative Narwhal Consensus on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9fdc7cca_93e7_4010_a33c_ea92e48626dc_241f47bb25.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NARWL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NARWL>>(v1);
    }

    // decompiled from Move bytecode v6
}

