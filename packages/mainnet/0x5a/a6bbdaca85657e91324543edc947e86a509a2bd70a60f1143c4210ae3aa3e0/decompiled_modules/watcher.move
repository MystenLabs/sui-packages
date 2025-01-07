module 0x5aa6bbdaca85657e91324543edc947e86a509a2bd70a60f1143c4210ae3aa3e0::watcher {
    struct WATCHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATCHER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<WATCHER>(arg0, 6, b"WATCHER", b"Whale Watcher", b"Follows and documents the top 20 tokens that smart money is flowing into at any given time.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_8233_d16d1aed70.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WATCHER>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATCHER>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

