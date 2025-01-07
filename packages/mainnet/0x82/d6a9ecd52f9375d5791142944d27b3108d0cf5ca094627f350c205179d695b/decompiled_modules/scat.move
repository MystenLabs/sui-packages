module 0x82d6a9ecd52f9375d5791142944d27b3108d0cf5ca094627f350c205179d695b::scat {
    struct SCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAT>(arg0, 6, b"SCAT", b"Shark Cat", b"A shark chat thing $SCAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sharkcatprof_559b821d07.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

