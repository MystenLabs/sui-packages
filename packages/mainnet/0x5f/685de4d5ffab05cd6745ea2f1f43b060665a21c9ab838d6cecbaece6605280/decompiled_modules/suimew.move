module 0x5f685de4d5ffab05cd6745ea2f1f43b060665a21c9ab838d6cecbaece6605280::suimew {
    struct SUIMEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMEW>(arg0, 6, b"SuiMEW", b"SuiCat in Doge world", x"f09f9aa8f09f90be205375692d4d656f7720697320686572652120f09f90b10a5468652070757272666563742063727970746f2074686174e2809973206d616b696e67206e6f69736520696e20746865206d61726b65742120f09f93880a526561647920746f20706f756e6365206f6e2074686f73652070726f666974733f20f09f98bcf09f92b020235375694d656f77202343727970746f2023535549202350757272666563744761696e7320234d656f774d6f766573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738659878584.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMEW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMEW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

