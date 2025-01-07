module 0x52eebb3e7aa4deab59381edf5079bc763b4bbde3f1f231820e55260bfc6f515d::kat {
    struct KAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAT>(arg0, 6, b"KAT", b"Karate kat", b"Bullie", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kat_2_cropped_3d5ff0fc3b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

