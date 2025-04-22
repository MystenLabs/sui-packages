module 0xc73995d1b26cb1382f423f33feb37abd2fa839924f52713dc57b6350a4cf19f4::jcb {
    struct JCB has drop {
        dummy_field: bool,
    }

    fun init(arg0: JCB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JCB>(arg0, 9, b"JCB", b"JACOB", b"JACOB_JCB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/98559ef2fd6a616e6499f61d7b85cedbblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JCB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JCB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

