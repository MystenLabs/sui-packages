module 0xf08374daaee97b903aed2d9422b7ae1988fc835b8a93f3edd636c9f412d66cfb::canary {
    struct CANARY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CANARY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CANARY>(arg0, 9, b"CANARY", b"Canary", b"Fortunte favours the brave.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://canarytokens.com/terms/pputi2j2dp7vee71u9fxm55ts/contact.php")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CANARY>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CANARY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CANARY>>(v1);
    }

    // decompiled from Move bytecode v6
}

