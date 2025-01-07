module 0xb5164b69c66363ed60d142b9c9b4965de8c09fb1e9c196374f2a1bcfff78e946::brf {
    struct BRF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRF>(arg0, 6, b"BRF", b"BROFANS", b"Become part of the Brofans revolution, where humor meets opportunity. Together, we can cultivate a future that not only entertains but also empowers our community within the cryptocurrency landscape.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/brf_high_resolution_logo_c462537fb3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRF>>(v1);
    }

    // decompiled from Move bytecode v6
}

