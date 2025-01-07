module 0xf06c274d6a6d03b399885be0a00c325430490c5b0a2415bd44d3d985e5e5bfb6::golem {
    struct GOLEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLEM>(arg0, 6, b"GOLEM", b"GOLEM CLUB", b"$GOLEM on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/qa_DVLM_Oa_400x400_c4b3ed7124.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOLEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

