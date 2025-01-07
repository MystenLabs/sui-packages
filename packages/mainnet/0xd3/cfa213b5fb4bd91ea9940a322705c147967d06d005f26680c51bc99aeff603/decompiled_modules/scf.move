module 0xd3cfa213b5fb4bd91ea9940a322705c147967d06d005f26680c51bc99aeff603::scf {
    struct SCF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCF>(arg0, 9, b"SCF", b"Smoking Chicken Fish", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pbs.twimg.com/profile_images/1828107281457704969/sNFVI1N1_400x400.jpg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SCF>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCF>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

