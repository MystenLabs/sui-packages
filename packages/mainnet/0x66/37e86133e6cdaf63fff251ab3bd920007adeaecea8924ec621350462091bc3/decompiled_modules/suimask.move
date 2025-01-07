module 0x6637e86133e6cdaf63fff251ab3bd920007adeaecea8924ec621350462091bc3::suimask {
    struct SUIMASK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMASK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMASK>(arg0, 6, b"SUIMASK", b"SuiMaskDog", x"4a6f696e207468652066756e207769746820537569204d61736b20446f672c2077686572652068756d6f72206d65657473207468652063727970746f20776f726c64212057657265206275696c64696e6720612076696272616e7420636f6d6d756e6974792077686572652065766572796f6e652063616e2074687269766520616e6420656e6a6f7920746865206a6f75726e6579206f66206469676974616c20696e766573746d656e742e20466574636820736f6d65206761696e7320616e642062652070617274206f6620736f6d657468696e67206578636974696e67210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_Mask_Dog_3307e1c817.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMASK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMASK>>(v1);
    }

    // decompiled from Move bytecode v6
}

