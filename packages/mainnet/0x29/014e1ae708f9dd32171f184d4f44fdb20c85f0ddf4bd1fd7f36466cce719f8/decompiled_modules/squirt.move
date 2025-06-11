module 0x29014e1ae708f9dd32171f184d4f44fdb20c85f0ddf4bd1fd7f36466cce719f8::squirt {
    struct SQUIRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIRT, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 791 || 0x2::tx_context::epoch(arg1) == 792, 1);
        let (v0, v1) = 0x2::coin::create_currency<SQUIRT>(arg0, 9, b"SQUIRT", b"SQUIRTLE", x"535549206d6f766573206c696b652077617465722e205371756972742069732077617465722e204974277320612070657266656374206f7665726c61703a20245351554952542069732061207369676e616c2e2041207368656c6c2d73686f636b65642c2073686164652d77656172696e6720737572676520746f77617264732061206e65772066726f6e746965722e2054686520233120506f6bc3a96d6f6e2066616e206d656d65206f6e205355492e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.filebase.io/ipfs/QmanjUwujyjMFhinXp7MxADrTTu9JnN965QpYefp6YzzvC"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SQUIRT>(&mut v2, 1000000000000000000, @0x9a42351212009c21434235d660feb3808172e05f86f256ec11b608297d9a62fd, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIRT>>(v2, @0x9a42351212009c21434235d660feb3808172e05f86f256ec11b608297d9a62fd);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SQUIRT>>(v1);
    }

    // decompiled from Move bytecode v6
}

