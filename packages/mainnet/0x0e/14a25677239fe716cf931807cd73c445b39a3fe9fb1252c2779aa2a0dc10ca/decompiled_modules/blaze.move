module 0xe14a25677239fe716cf931807cd73c445b39a3fe9fb1252c2779aa2a0dc10ca::blaze {
    struct BLAZE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAZE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLAZE>(arg0, 6, b"Blaze", b"Blaze on Sui", x"48656c6c6f2c2049276d2024424c415a45210a0a526561647920746f206275726e207468726f756768207468652063727970746f207363656e65206f6e205375693f20496d0a6669657263652c20666173742c20616e64206f6e20666972657065726665637420666f722074686f73652077686f206c696b650a7468656972206d656d657320617320686f74206173207468656972206761696e7321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/blaze_profile_274d1046e9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLAZE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLAZE>>(v1);
    }

    // decompiled from Move bytecode v6
}

