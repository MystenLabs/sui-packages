module 0xf2a0d0cfb5b98708952037f5b8e887311d4edf10caf1dd55ba35f888d70920fd::clnt {
    struct CLNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLNT>(arg0, 6, b"CLNT", b"COLONER TRUMP", b"I LOVE THE HAIR!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_02_11_08_50_04_3a3aa72a2c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLNT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLNT>>(v1);
    }

    // decompiled from Move bytecode v6
}

