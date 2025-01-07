module 0x936429921aca2177d6c4f56706bc147ca7861b0a232c059bf07d73459ab079e::ferret {
    struct FERRET has drop {
        dummy_field: bool,
    }

    fun init(arg0: FERRET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FERRET>(arg0, 6, b"FERRET", b"ferret the heck", b"the heck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/theheck_fe7841b3f3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FERRET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FERRET>>(v1);
    }

    // decompiled from Move bytecode v6
}

