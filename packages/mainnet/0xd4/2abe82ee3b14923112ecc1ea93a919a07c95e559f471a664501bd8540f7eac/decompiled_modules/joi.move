module 0xd42abe82ee3b14923112ecc1ea93a919a07c95e559f471a664501bd8540f7eac::joi {
    struct JOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOI>(arg0, 6, b"JOI", b"Joitoken", x"57656c636f6d6520746f20746865204a6f69746f6b656e2050554d5021200a4a6f69746f6b656e206973206d6f7265207468616e206a7573742061206d656d65636f696e3b206974277320612072617069646c792067726f77696e6720636f6d6d756e6974792077697468206120626f6c6420676f616c3a20746f2074616b65204a6f692c206f75722062656c6f766564206e65726479206368617261637465722c20746f2074686520544f50203130206f662074686520776f726c642773206c656164696e67206d656d65636f696e73210a574542534954453a68747470733a2f2f6a6f69746f6b656e2e636f6d2f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1723740500184_6e0f088b9744b5e6e0a2edce684fcb79_e4ebd70258.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOI>>(v1);
    }

    // decompiled from Move bytecode v6
}

