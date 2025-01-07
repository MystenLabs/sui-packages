module 0xaa9e647fc1d74a28570f91fd5785b6a37420c640a23f5b8d17b080941f32846e::suica {
    struct SUICA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICA>(arg0, 6, b"SUICA", b"Suica The Whale", b"Meet Suica the Whale! With a big smile and a heart full of joy, Suica is here to spread happiness and fun in the crypto ocean. Dive in with Suica and discover his delightful world - where every splash counts! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thumb_fcddf9a735.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICA>>(v1);
    }

    // decompiled from Move bytecode v6
}

