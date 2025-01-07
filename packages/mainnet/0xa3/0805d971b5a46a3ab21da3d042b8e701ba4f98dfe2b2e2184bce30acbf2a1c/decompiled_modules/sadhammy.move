module 0xa30805d971b5a46a3ab21da3d042b8e701ba4f98dfe2b2e2184bce30acbf2a1c::sadhammy {
    struct SADHAMMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SADHAMMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SADHAMMY>(arg0, 6, b"SADHAMMY", b"Sad Hamster World", x"5361642048616d73746572202853414448414d4d5929204d656d6520636f696e206973206120746f6b656e20666f72207468652070656f706c65206279207468652070656f706c652e205573696e6720726f6c6c206f75742073747261746567696573206e65766572207365656e206265666f72652c2077652077696c6c2074616b65206f766572207468652063727970746f206d656d652073706163652e2020436f6d6d756e6974792046697273742e205472616e73706172656e63792046697273742e204174207468652073616d652074696d652e20204a75737420547279696e67204f757220426573742e20f09f9189f09f9188", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732755001538.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SADHAMMY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SADHAMMY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

