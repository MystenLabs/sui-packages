module 0xd9c567ecc3485154f56b0e79eaf12dfae88f26fd9f787a9f3f845bdd79cdd5ca::runner {
    struct RUNNER has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUNNER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUNNER>(arg0, 6, b"RUNNER", b"HOMESTAR RUNNER", b"homestar.meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GT_1_UB_Bmj_400x400_7be09961e5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUNNER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUNNER>>(v1);
    }

    // decompiled from Move bytecode v6
}

