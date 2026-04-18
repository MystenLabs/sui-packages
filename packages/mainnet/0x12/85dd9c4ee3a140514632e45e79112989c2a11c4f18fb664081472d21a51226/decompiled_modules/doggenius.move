module 0x1285dd9c4ee3a140514632e45e79112989c2a11c4f18fb664081472d21a51226::doggenius {
    struct DOGGENIUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGGENIUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGGENIUS>(arg0, 9, b"DogGenius", b"DogGeniusWifHat", b"DogGeniusWifHat good coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1776530077483-bdf1675b6d97ced3011de98091dcf111.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<DOGGENIUS>>(0x2::coin::mint<DOGGENIUS>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGGENIUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGGENIUS>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

