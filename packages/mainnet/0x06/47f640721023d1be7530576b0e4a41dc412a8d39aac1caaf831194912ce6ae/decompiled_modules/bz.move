module 0x647f640721023d1be7530576b0e4a41dc412a8d39aac1caaf831194912ce6ae::bz {
    struct BZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BZ>(arg0, 6, b"BZ", b"BOTZILL", b"BZ ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/p3d_Ew7_TQ_400x400_d841b32449.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

