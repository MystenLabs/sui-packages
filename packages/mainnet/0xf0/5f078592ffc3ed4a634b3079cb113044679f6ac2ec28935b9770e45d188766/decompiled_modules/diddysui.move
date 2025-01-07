module 0xf05f078592ffc3ed4a634b3079cb113044679f6ac2ec28935b9770e45d188766::diddysui {
    struct DIDDYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIDDYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIDDYSUI>(arg0, 6, b"DIS", b"DiddySui", b"wanna join Diddy's party?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"black-hilarious-porcupine-521.mypinata.cloud/ipfs/Qmf3kM69cvrDeK7mdLCS3zBCfjftDyDybNWfcxtw6xC2P6"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIDDYSUI>>(v1);
        0x2::coin::mint_and_transfer<DIDDYSUI>(&mut v2, 1000000000000000, @0x1392c2c5f08a3f775c9cf58e7ac6ecffaf1dd96725c505619cc281eb7f4ebb5e, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIDDYSUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

