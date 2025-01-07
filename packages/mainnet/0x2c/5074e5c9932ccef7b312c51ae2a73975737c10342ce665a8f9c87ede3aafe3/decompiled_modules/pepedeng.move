module 0x2c5074e5c9932ccef7b312c51ae2a73975737c10342ce665a8f9c87ede3aafe3::pepedeng {
    struct PEPEDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEDENG>(arg0, 6, b"PEPEDENG", b"Pepe Deng", b"Step right up, folks, and feast your eyes on the one and only Pepe Deng! Half", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241010_010917_037_b77cfeef56_cf5031c1ab.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPEDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

