module 0x22eb6c47df8d3164e23e1130cbb9188a7b1219ef0a54669ffcbc3c478fbfab1d::bek {
    struct BEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEK>(arg0, 6, b"BEK", b"Blue Eyed Koala", b"A blue eyed koala.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/animals_with_blue_eyes_in_the_wild_1_6d7841bead.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEK>>(v1);
    }

    // decompiled from Move bytecode v6
}

