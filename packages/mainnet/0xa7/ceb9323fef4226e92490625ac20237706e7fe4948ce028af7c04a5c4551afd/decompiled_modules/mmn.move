module 0xa7ceb9323fef4226e92490625ac20237706e7fe4948ce028af7c04a5c4551afd::mmn {
    struct MMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMN>(arg0, 6, b"MMN", b"MooManow", b"MooManow is a single small hippo in Kaokeaw.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MMN_c5ee55420b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MMN>>(v1);
    }

    // decompiled from Move bytecode v6
}

