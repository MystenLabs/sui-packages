module 0x568100200046379d69611930fc73b540248cffb8adb087a7d9b4b9ace8cc6907::b_pumpkin {
    struct B_PUMPKIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_PUMPKIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_PUMPKIN>(arg0, 9, b"bPUMPKIN", b"bToken PUMPKIN", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_PUMPKIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_PUMPKIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

