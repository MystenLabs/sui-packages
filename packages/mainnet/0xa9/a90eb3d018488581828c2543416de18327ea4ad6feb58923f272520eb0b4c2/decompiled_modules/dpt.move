module 0xa9a90eb3d018488581828c2543416de18327ea4ad6feb58923f272520eb0b4c2::dpt {
    struct DPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DPT>(arg0, 6, b"DPT", b"DEEPtober", b"memecoin dedicated the deepbook community and upcoming tge", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000015273_998a2c80a6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DPT>>(v1);
    }

    // decompiled from Move bytecode v6
}

