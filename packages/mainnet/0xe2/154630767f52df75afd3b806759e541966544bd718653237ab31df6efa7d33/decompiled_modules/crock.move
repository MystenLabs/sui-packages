module 0xe2154630767f52df75afd3b806759e541966544bd718653237ab31df6efa7d33::crock {
    struct CROCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROCK>(arg0, 6, b"CROCK", b"SuiWitcCrock", b"cute cat is a crock", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000068833_d79aaf9f2f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CROCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

