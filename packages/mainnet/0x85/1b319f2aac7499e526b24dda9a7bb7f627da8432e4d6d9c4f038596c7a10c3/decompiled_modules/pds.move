module 0x851b319f2aac7499e526b24dda9a7bb7f627da8432e4d6d9c4f038596c7a10c3::pds {
    struct PDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PDS>(arg0, 6, b"PDS", b"Pinkdoog on sui", b"Welcome to the world of PinkDoggo! Join us in exploring the community, sharing our passion for crypto, and connecting with new friends.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_01_10_12_50_15_2a976f1066.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

