module 0x25a653a0dc72c2edd437f5909618ac41c274730bdcc2fc08b93708e10749f0e4::Skulleton {
    struct SKULLETON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKULLETON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKULLETON>(arg0, 9, b"SKULL", b"Skulleton", b"SKULLATOR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/e8ca9d85-7e59-4e9f-aaf9-ebb745f5aef0.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKULLETON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKULLETON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

