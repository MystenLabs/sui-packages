module 0x2f8abc4b8090a0ac236b0eb26d1ab0df83a514ca8536222de31201e00d99290d::haedal {
    struct HAEDAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAEDAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAEDAL>(arg0, 9, b"HAEDALTEST", b"Haedal Test Coin", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://node1.irys.xyz/Rp80fmqZS3qBDnfyxyKEvc65nVdTunjOG3NY8T6AjpI"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAEDAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAEDAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

