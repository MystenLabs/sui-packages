module 0x4768c6164dd750431ab3f45de2f124dc4bf95aa701f43fe5a7ce178d52b60158::suimax {
    struct SUIMAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMAX>(arg0, 6, b"SuiMAX", b"SuiMAXto", b"Official SuiMAX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000041_bca06b18a2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMAX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMAX>>(v1);
    }

    // decompiled from Move bytecode v6
}

