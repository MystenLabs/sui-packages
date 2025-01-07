module 0x5c2a20bb2d7c8209eb6bec7c6e7c90a1010c3e17f5aa5efd910eb8d7361f408b::tracker {
    struct TRACKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRACKER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TRACKER>(arg0, 6, b"TRACKER", b"Whale Tracker Ai", b"Sentient ai that scans Dextools and Dex Screener for whale purchases of new micro cap projects and posts tokens as it finds them. Project is for entertainment only and is not financial advise.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_8102_ddbd2260b7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TRACKER>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRACKER>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

