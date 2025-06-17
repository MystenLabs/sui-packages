module 0x50d055c4c73bebd63bac4d90f3a68862e70d56691d67dd88bd364a4de0d7219d::cpr {
    struct CPR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CPR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CPR>(arg0, 9, b"CPR", b"copper", b"aidrop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a51e9fe14bb21ff38b328dfeab396e26blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CPR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CPR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

