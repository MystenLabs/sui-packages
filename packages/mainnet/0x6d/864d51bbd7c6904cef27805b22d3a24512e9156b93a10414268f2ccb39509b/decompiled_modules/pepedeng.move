module 0x6d864d51bbd7c6904cef27805b22d3a24512e9156b93a10414268f2ccb39509b::pepedeng {
    struct PEPEDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEDENG>(arg0, 6, b"PEPEDENG", b"Pepe Deng", b"feast your eyes on the one and only Pepe Deng! Half", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241010_010917_037_b77cfeef56_881184dcd2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPEDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

