module 0x2383111fbf37955ee282e2aa2845bc11b68b6e9381ad4a311fccd4189e23fbca::donald {
    struct DONALD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONALD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONALD>(arg0, 6, b"DONALD", b"James A Donald", b"Community coin paying homage to the true identity of Satoshi Nakamoto -- James A Donald", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003135_c6ae9e6281.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONALD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONALD>>(v1);
    }

    // decompiled from Move bytecode v6
}

