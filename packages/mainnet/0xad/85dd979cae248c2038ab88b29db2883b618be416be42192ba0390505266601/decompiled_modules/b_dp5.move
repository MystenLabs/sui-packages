module 0xad85dd979cae248c2038ab88b29db2883b618be416be42192ba0390505266601::b_dp5 {
    struct B_DP5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_DP5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_DP5>(arg0, 9, b"bDP5", b"bToken DP5", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_DP5>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_DP5>>(v1);
    }

    // decompiled from Move bytecode v6
}

