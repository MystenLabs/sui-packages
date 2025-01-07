module 0x191b8eeb91002ac5dee1190a1ad0499c625206bf688fb2965d69b160bf0ddc1f::dogemoji {
    struct DOGEMOJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGEMOJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGEMOJI>(arg0, 9, b"DOGEMOJI", b"DOG EMOJI on SUI", x"446f676520456d6f6a692068617320636c61696d6564206869732073706f74206f6e2074686520537569204f6365616e2c20616e64206e6f77206865e2809973206f75742068657265206261726b696e6720757020657665727920636f726e657220686520737465707320696e746f2120f09f90be2054686973206c6974746c6520656d6f6a692069736ee2809974206a7573742061646f7261626c65e280946865e2809973206f6e2061206d697373696f6e20746f20696e73706972652074686520776f726c642061626f7574207468652067726561746e657373206f6620646f6773", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1871045333830307840/-HQExMUd_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOGEMOJI>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGEMOJI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGEMOJI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

