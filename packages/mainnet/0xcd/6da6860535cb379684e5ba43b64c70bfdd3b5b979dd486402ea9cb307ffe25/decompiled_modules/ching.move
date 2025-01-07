module 0xcd6da6860535cb379684e5ba43b64c70bfdd3b5b979dd486402ea9cb307ffe25::ching {
    struct CHING has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHING>(arg0, 6, b"Ching", b"Evon Ching", x"4576616e204368656e677327207265746172646564207477696e20244348494e47206368696368696e67206f6e20245355490a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2f8ece7d_292d_4ce8_9fc3_584863abbdc8_893a00dca1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHING>>(v1);
    }

    // decompiled from Move bytecode v6
}

