module 0x46bbe5b4ed1099c22f5e98d4ae5d9f8f7b94ad1d703f0c24d579bc57555ae228::sasha {
    struct SASHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SASHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SASHA>(arg0, 6, b"SASHA", b"Sasha", b"Miners dug through his tweets and found Len's cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/255125568_1_d4d0aa9ff8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SASHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SASHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

