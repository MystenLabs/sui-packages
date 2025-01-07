module 0xdf2b810f07a0ecc367f9d5f3222fc4b0c09c9a1ce47aac576d9473095bff7399::fetus {
    struct FETUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FETUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FETUS>(arg0, 6, b"FETUS", b"Fetus", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfSuXAySEwWFc0CV-ftHgHluvc6Jo3upw_HA&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FETUS>(&mut v2, 33333333334000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FETUS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FETUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

