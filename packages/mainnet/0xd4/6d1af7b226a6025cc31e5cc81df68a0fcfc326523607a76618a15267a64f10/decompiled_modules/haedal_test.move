module 0xd46d1af7b226a6025cc31e5cc81df68a0fcfc326523607a76618a15267a64f10::haedal_test {
    struct HAEDAL_TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAEDAL_TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAEDAL_TEST>(arg0, 9, b"HAEDALTEST", b"Haedal Test Coin", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://node1.irys.xyz/Rp80fmqZS3qBDnfyxyKEvc65nVdTunjOG3NY8T6AjpI"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAEDAL_TEST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAEDAL_TEST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

