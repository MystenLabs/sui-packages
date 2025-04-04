module 0x240f2c0583d866d68660068f80d0c2837ac14e93ba1b1dbfaa8dbcd13b34a21b::zahargre {
    struct ZAHARGRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZAHARGRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZAHARGRE>(arg0, 9, b"Zahargre", b"zahar", b"Zahar", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/16a52fbd68bae21a813dfe1161a5dec9blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZAHARGRE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZAHARGRE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

