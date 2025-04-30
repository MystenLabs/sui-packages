module 0x11a3e8933c03c2adaefd72c292b8e4cf9e280b49d4d2d516dd37e39ef6a1fb34::sblob {
    struct SBLOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBLOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBLOB>(arg0, 6, b"SBLOB", b"Sui  Blob", b"Tired of getting rugged on stupid Memecoins like me? Join the SBLOB! It's Original, fun and risk free. Website & X links are coming. Join the TELLY. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Chat_GPT_Image_30_Nis_2025_23_39_47_d977bf3f92.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBLOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBLOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

