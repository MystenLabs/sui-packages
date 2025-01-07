module 0x3ad0d91bf16756c820bf5f49d658e8b844be2888a620565ccf11b39c5b94206a::suispin888 {
    struct SUISPIN888 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISPIN888, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISPIN888>(arg0, 6, b"SUISPIN888", b"SUISEASPIN888", b"Sui Sea Spin Token integrates with online poker platforms, allowing users to play poker using the Token  as the in-game currency. This offers a unique way for users to utilize their tokens and participate in online poker games.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3493_2ee60f68c6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISPIN888>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISPIN888>>(v1);
    }

    // decompiled from Move bytecode v6
}

