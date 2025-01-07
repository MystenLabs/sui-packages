module 0x809d350b739856ec061b56c300cde5c7326f2139a82ed5d2b1fb319bf7cb0692::poon {
    struct POON has drop {
        dummy_field: bool,
    }

    fun init(arg0: POON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POON>(arg0, 6, b"POON", b"POON On SUI", b" Poon has always dreamed of amassing crypto wealth beyond his wildest dreams.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6609776c0de08fa8f403b365_webclip_d30b500c76.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POON>>(v1);
    }

    // decompiled from Move bytecode v6
}

