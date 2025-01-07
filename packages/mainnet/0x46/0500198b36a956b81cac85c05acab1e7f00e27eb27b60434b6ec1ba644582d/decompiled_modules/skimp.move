module 0x460500198b36a956b81cac85c05acab1e7f00e27eb27b60434b6ec1ba644582d::skimp {
    struct SKIMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKIMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKIMP>(arg0, 6, b"SKIMP", b"Ski Mask Peanut", b"SKIMP- Peanut is on the Sui network and is ski-masked up", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009168_2491cd9e0c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKIMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKIMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

