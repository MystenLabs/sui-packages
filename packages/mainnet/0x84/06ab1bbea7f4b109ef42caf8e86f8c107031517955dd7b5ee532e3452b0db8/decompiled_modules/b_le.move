module 0x8406ab1bbea7f4b109ef42caf8e86f8c107031517955dd7b5ee532e3452b0db8::b_le {
    struct B_LE has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_LE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_LE>(arg0, 9, b"bLE", b"bToken LE", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_LE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_LE>>(v1);
    }

    // decompiled from Move bytecode v6
}

