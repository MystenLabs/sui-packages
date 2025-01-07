module 0xff2a3595d1e15e57e698e52e70216599b5ae9ee98238ca199edb66eb931432e7::backup {
    struct BACKUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BACKUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BACKUP>(arg0, 6, b"BackUP", b"Back up", b"Back up on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_output_ba4441ddaf.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BACKUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BACKUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

