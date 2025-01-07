module 0x17e0ea487187e0d464f14fb388408443861499a228eb14d83921b8d36570d70::bcat {
    struct BCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCAT>(arg0, 6, b"BCAT", b"bull cat", b"To the highest heights with the Taurus cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cff7a1fe_fb5b_4132_8b30_53eac521b417_4763b79e95.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

