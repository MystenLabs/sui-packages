module 0x19fffb80ba5f97ad73bc48a8919a3034aa6e85dd3ffea7b898634bcb8bcc6a67::zzzz {
    struct ZZZZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZZZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZZZZ>(arg0, 9, b"ZZZZ", b"SleepyToken", x"4561726e207768696c6520796f7520736e6f6f7a652e20536c65657079546f6b656e207265776172647320796f7520666f72206865616c74687920736c656570207061747465726e73207573696e6720736c6565702d747261636b696e6720696e746567726174696f6e732e20496465616c20666f722077656c6c6e65737320656e7468757369617374732c2062696f6861636b6572732c20616e6420616e796f6e652077686f20647265616d73206f66207061737369766520696e636f6d6520e28094206c69746572616c6c792e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/4ee74fe1e32a2d8115a6590c3ffae53cblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZZZZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZZZZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

