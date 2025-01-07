module 0x75e76018502c34ea8209990bf63d4d9f86649252703ca337d13599ded00c6d13::dory {
    struct DORY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DORY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DORY>(arg0, 6, b"Dory", b"dory", b"Finding dory on sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/finding_nemo_talking_254f386d01.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DORY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DORY>>(v1);
    }

    // decompiled from Move bytecode v6
}

