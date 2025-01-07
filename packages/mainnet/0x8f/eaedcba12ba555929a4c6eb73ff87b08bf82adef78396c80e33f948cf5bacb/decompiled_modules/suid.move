module 0x8feaedcba12ba555929a4c6eb73ff87b08bf82adef78396c80e33f948cf5bacb::suid {
    struct SUID has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUID>(arg0, 9, b"SUID", b"SUIDOG", x"535549444f47206973206120636f6d6d756e6974792d64726976656e206d656d6520746f6b656e206f6e207468652053554920426c6f636b636861696e2c20696e7370697265642062792063727970746f2063756c747572652e204974e2809973206d6f7265207468616e206120746f6b656ee280946974e28099732061207061636b206f66206c696b652d6d696e64656420656e7468757369617374732076616c75696e672068756d6f722c20726573696c69656e63652c20616e6420696e6e6f766174696f6e2e204a6f696e20535549444f4720616e64206c6561766520796f7572207061777072696e74206f6e2074686520626c6f636b636861696e210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1614e816-574d-4786-a597-a1d20ce287e1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUID>>(v1);
    }

    // decompiled from Move bytecode v6
}

