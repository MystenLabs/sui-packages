module 0x99935d76aa7a806a7c7fda30ee6279d17b6146a8d905323bdce4b190513a862c::pox {
    struct POX has drop {
        dummy_field: bool,
    }

    fun init(arg0: POX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POX>(arg0, 6, b"POX", b"Sui Pox", b"$POX is memecoin on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9344_f2b74b61fc.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POX>>(v1);
    }

    // decompiled from Move bytecode v6
}

