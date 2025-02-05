module 0xe912feb56910bd4a55fa8fbcadd764c4e90d1645874136e5a7a4d05079486fe7::cozy {
    struct COZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: COZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COZY>(arg0, 9, b"COZY", b"Nice, fluffy and Cozy Rug", b"What a nice rug", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/6bbfed1777d00c0b91670a9b116982efblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COZY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COZY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

