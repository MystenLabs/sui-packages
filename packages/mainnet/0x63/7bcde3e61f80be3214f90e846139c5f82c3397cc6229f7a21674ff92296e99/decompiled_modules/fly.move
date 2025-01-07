module 0x637bcde3e61f80be3214f90e846139c5f82c3397cc6229f7a21674ff92296e99::fly {
    struct FLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLY>(arg0, 6, b"FLY", b"Flying Snow Cat", b"SNOW CAT FLYING TO THE MOON ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pictures_of_Truly_Adorable_Animals_in_Snow_23_3ddd564203.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

