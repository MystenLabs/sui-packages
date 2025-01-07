module 0x60fde6dce19c3accbacdef3376bef9155dfe2ba9b48f3f31e124b62dab98f3b9::gloo {
    struct GLOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLOO>(arg0, 6, b"Gloo", b"SUIGLOO", x"43616e7420796f75207365652053554920636f6d6d756e69747920464f4d4f204f4e20474c4f4f3f0a0a476c6f6f206973206c696b6520612074696e792c20776f62626c7920736b792064726f702077697468206c656773212042696720657965732c20737475626279206c6974746c6520666565742c20616e64206120636c756d737920636861726d2074686174206d616b65732068657220697272657369737469626c7920637574652e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241015_000457_543_34c79f8e66.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

