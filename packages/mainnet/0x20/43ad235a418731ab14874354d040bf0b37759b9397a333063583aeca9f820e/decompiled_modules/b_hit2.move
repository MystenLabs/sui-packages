module 0x2043ad235a418731ab14874354d040bf0b37759b9397a333063583aeca9f820e::b_hit2 {
    struct B_HIT2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_HIT2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_HIT2>(arg0, 9, b"bHIT2", b"bToken HIT2", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_HIT2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_HIT2>>(v1);
    }

    // decompiled from Move bytecode v6
}

