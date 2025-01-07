module 0x984303d39e84d1a5b1e33ebe4288793256ddad45e4c17073c3c944293f6ca7ac::nvda6900 {
    struct NVDA6900 has drop {
        dummy_field: bool,
    }

    fun init(arg0: NVDA6900, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NVDA6900>(arg0, 6, b"NVDA6900", b"NVDA", b"Never Volatile Definitely Ape 6900", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1500x500_47f58bfce4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NVDA6900>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NVDA6900>>(v1);
    }

    // decompiled from Move bytecode v6
}

