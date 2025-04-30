module 0x712850c25fefe5efe613d571b3d839a23f4f596aee5a42535e141be38f2926ca::bunkercoin {
    struct BUNKERCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUNKERCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUNKERCOIN>(arg0, 6, b"BUNKERCOIN", b"bunkercoin", b"This is a safe investment (BUNKERCOIN)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bu_nker_coin_43af49dd50.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUNKERCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUNKERCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

