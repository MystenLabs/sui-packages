module 0x736928173948aa2862b7508281cd87f1d46eac261b6cd101ccc3c0c9f5a57505::baa {
    struct BAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAA>(arg0, 6, b"BAA", b"baa sheep", b"@BaaSheepOnSui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TO_Kl_M0pl_400x400_1_193ec20f18.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

