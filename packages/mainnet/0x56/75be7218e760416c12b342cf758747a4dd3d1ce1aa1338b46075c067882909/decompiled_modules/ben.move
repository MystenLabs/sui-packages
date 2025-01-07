module 0x5675be7218e760416c12b342cf758747a4dd3d1ce1aa1338b46075c067882909::ben {
    struct BEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEN>(arg0, 6, b"BEN", b"Ben the fish", b"Ben is a fish on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_465abe49d0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

