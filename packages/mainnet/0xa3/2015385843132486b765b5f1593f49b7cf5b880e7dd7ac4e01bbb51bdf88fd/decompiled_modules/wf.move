module 0xa32015385843132486b765b5f1593f49b7cf5b880e7dd7ac4e01bbb51bdf88fd::wf {
    struct WF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WF>(arg0, 6, b"WF", b"Water Frog", b"Water Frog on sui loL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/frog_e1x_e423e9c80e.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WF>>(v1);
    }

    // decompiled from Move bytecode v6
}

