module 0x4bf628a7cd1da7ac4f15274296498749c9c5ed149c849686f5e05abad10da6ef::psyducksui {
    struct PSYDUCKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSYDUCKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSYDUCKSUI>(arg0, 9, b"PsyDuckSui", b"PsyDuck Sui", x"4163636964656e74616c6c79206c61756e636865642e20496e74656e74696f6e616c6c79207374757069642e204275696c74206f6e20245355492e20506f7765726564206279206d69677261696e657320616e64206d656d65732e204368617274e28099732061206d7973746572792e20446576e2809973206120245053592e20f09fa7a0204f7572207574696c6974793f20436f6e667573696f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/091716d2c0ef9cda40d6b33c54a3fd69blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PSYDUCKSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSYDUCKSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

