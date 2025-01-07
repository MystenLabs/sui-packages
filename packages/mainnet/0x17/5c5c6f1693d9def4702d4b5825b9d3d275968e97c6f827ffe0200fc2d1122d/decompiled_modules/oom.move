module 0x175c5c6f1693d9def4702d4b5825b9d3d275968e97c6f827ffe0200fc2d1122d::oom {
    struct OOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: OOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OOM>(arg0, 6, b"OOM", b"On My Momma", b"on my momma im max bidding $OMM with every fucking penny i have", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241203_173226_305_97a08811c5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

