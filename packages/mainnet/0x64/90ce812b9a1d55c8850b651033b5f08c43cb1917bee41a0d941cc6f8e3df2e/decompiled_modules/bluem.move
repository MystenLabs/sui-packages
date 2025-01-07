module 0x6490ce812b9a1d55c8850b651033b5f08c43cb1917bee41a0d941cc6f8e3df2e::bluem {
    struct BLUEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEM>(arg0, 6, b"BLUEM", b"BLUEM ON SUI", x"424c55422c20485355492043757272656e746c79206120766572792066616d6f7573206d656d65206f6e207375692e2042757420746f64617920424c55454d20535549206c61756e63686573206f6e20737569206f6365616e2077696c6c206f70656e2061206e657720657261206f66206d656d6573206f6e207375692c20424c55454d2077696c6c207269736520746f206265636f6d6520746865206e6577204b696e67206f66206d656d6573206f6e207375690a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4d8afab6b55b1903bbabc9328833342d_0facdcfbed.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

