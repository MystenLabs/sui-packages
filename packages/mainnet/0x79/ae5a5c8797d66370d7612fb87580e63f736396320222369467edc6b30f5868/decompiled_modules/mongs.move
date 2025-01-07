module 0x79ae5a5c8797d66370d7612fb87580e63f736396320222369467edc6b30f5868::mongs {
    struct MONGS has drop {
        dummy_field: bool,
    }

    public entry fun increase_supply(arg0: &mut 0x2::coin::TreasuryCap<MONGS>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x6f2c8f236d13636292b8776f2fafbedddb29aea4547fd26ed585cf27a62c979f, 1);
        let v0 = 0x2::tx_context::sender(arg2);
        minto(arg0, v0, arg1, arg2);
    }

    fun init(arg0: MONGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONGS>(arg0, 6, b"MS", b"RELAUNCH TODAY https://t.me/MongSUI", b"ELAUNCH TODAY https://t.me/MongSUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/h0omlTj.jpg"))), arg1);
        let v2 = v0;
        let v3 = @0x6f2c8f236d13636292b8776f2fafbedddb29aea4547fd26ed585cf27a62c979f;
        0x2::coin::mint_and_transfer<MONGS>(&mut v2, 1000000000, v3, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MONGS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONGS>>(v2, v3);
    }

    public entry fun minto(arg0: &mut 0x2::coin::TreasuryCap<MONGS>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x6f2c8f236d13636292b8776f2fafbedddb29aea4547fd26ed585cf27a62c979f, 1);
        0x2::coin::mint_and_transfer<MONGS>(arg0, arg2, arg1, arg3);
    }

    // decompiled from Move bytecode v6
}

