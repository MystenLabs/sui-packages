module 0x53c00617fb1f35bf32eee397a291dac792aab538ab9a42c87738a2bc9f9418b1::ladislaus {
    struct LADISLAUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LADISLAUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LADISLAUS>(arg0, 6, b"LADISLAUS", b"Ladislaus V the Posthumous", b"Ladislaus V, the Posthumous (1440-1457); Duke of Austria and King of Hungary, Croatia and Bohemia. Original Boys Club member. He was the posthumous son of Albert of Habsburg with Elizabeth of Luxembourg, as well as the inventor of the White Pill. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LADISLAUS_526a531833.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LADISLAUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LADISLAUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

