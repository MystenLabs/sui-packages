module 0x3bbbb56987eaaeafdcc9c45f918222aa54d7510bffce865554ee1128a2dc93a2::b_zzz {
    struct B_ZZZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_ZZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_ZZZ>(arg0, 9, b"bZZZ", b"bToken ZZZ", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_ZZZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_ZZZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

