module 0x6ea0fbdefbe9702e83764d721d1f0bb1ec1808a5e790188d2df18dcf559fc39d::bee {
    struct BEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEE>(arg0, 9, b"BEE", b"bee", x"42757a7a20696e746f2074686520667574757265207769746820426565436f696e3a205468652073776565746573742063727970746f63757272656e63792074686174277320616c6c206162757a7a207769746820686f6e65792d7377656574206d656d657320616e6420686976652d6d696e6420726577617264732120f09f909df09f92b0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9e1662cc-8578-4451-864b-002a32d1fe6a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

