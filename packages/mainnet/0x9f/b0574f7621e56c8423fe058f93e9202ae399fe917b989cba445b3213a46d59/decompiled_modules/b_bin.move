module 0x9fb0574f7621e56c8423fe058f93e9202ae399fe917b989cba445b3213a46d59::b_bin {
    struct B_BIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_BIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_BIN>(arg0, 9, b"bBIN", b"bToken BIN", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_BIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_BIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

