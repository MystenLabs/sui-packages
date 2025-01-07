module 0x817cf599636825a57ea0d368c5bbe6cf99c4cf50a25b8a0166ef4a8292875fd3::scui {
    struct SCUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCUI>(arg0, 7, b"SCUI", b"Swingui club ", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://res.cloudinary.com/jerrick/image/upload/d_642250b563292b35f27461a7.png,f_jpg,fl_progressive,q_auto,w_1024/oqh4jaoh2sclrdml4pkq.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SCUI>(&mut v2, 69696969700000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

