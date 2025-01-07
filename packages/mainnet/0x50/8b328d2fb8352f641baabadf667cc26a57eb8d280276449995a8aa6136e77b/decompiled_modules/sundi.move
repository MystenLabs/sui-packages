module 0x508b328d2fb8352f641baabadf667cc26a57eb8d280276449995a8aa6136e77b::sundi {
    struct SUNDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUNDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNDI>(arg0, 6, b"SUNDI", b"Sundi on Sui", b"Hi, I'm Sundi, people call me the fastest dog on the planet,and I agree", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/speedy_485344eba5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUNDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

