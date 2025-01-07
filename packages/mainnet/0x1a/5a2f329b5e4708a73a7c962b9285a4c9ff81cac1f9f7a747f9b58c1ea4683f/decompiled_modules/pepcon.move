module 0x1a5a2f329b5e4708a73a7c962b9285a4c9ff81cac1f9f7a747f9b58c1ea4683f::pepcon {
    struct PEPCON has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPCON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPCON>(arg0, 6, b"PepCon", b"PepeConference", b"PepCon inspired by the upcoming rates cuts and going to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004388_e8d22596a0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPCON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPCON>>(v1);
    }

    // decompiled from Move bytecode v6
}

