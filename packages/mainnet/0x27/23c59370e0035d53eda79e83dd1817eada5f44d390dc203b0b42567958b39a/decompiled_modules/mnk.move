module 0x2723c59370e0035d53eda79e83dd1817eada5f44d390dc203b0b42567958b39a::mnk {
    struct MNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MNK>(arg0, 6, b"MNK", b"monk", b"monky", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6269_988de31485.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

