module 0xee7bd53ef1a95ee751eb4eb5dfaa6c2d69facab7dd6d770dbe48d65f9f7e2c37::birdy {
    struct BIRDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIRDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIRDY>(arg0, 6, b"BIRDY", b"BIRDY on SUI", b"#Birdy empowers users with blockchain, offering tokenized assets, NFTs,GameFi, and Charity All While Rescuing Dogs Globally", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/W_Pnz_Lrt_J_400x400_17fa6e16f3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIRDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIRDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

