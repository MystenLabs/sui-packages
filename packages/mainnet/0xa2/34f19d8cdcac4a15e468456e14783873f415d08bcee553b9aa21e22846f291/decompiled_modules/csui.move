module 0xa234f19d8cdcac4a15e468456e14783873f415d08bcee553b9aa21e22846f291::csui {
    struct CSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CSUI>(arg0, 6, b"CSUI", b"Chopped Sui", x"5468652070726f6a6563742061696d7320746f206c657665726167652074686520706f70756c6172697479206f66206d656d65666920636f696e7320616e6420706f736974696f6e20697473656c662061732061206e6f7461626c65206d656d652d6261736564206469676974616c2061737365742e20546865207269626269742074686174e28099732069676e6974696e672074686520667574757265206f6620646563656e7472616c697a65642066696e616e636520697320686572652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731097357912.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

