module 0x871c0c7f3958c3f8506ed4e0310a9a0bd567f57572409aab35a0ba8c130bd713::return_sui {
    struct RETURN_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RETURN_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RETURN_SUI>(arg0, 6, b"RETURN_SUI", b"GIVE ME BACK MY MONE", x"f09f94a52054484953204953204e4f54204a555354204120544f4b454e2e205448495320495320412053435245414d2e205448495320495320524147452e205448495320495320524556454e4745210a0a496e206120736561206f662073776565742070726f6d697365732c2072756770756c6c732c20686f6e6579706f74732c20616e642062726f6b656e20647265616d732c206f6e65206c6f756420766f6963652072697365732066726f6d2074686520696e766573746f72732077686fe2809976652068616420656e6f7567683a0a2247495645204d45204241434b204d59204d4f4e4559212121220a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1750232902873.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RETURN_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RETURN_SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

