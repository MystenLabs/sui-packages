module 0x42eb65bc88f0963baae4d79da6d7d44b9b48cf0692c0b8fe608bf9e3803f8cc::evrdog {
    struct EVRDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVRDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVRDOG>(arg0, 6, b"EVRDOG", b"Everdogtoken", b"Join the pack, and discover the world of #EVRDOG where every dog is for everyone, and everyone has their Dog.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Elu_MM_Nd6_400x400_a465575fc2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVRDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EVRDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

