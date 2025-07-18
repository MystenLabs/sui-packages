module 0x2ed534be37b025ad6508e5b438fcc9447033987f293d079378d87b1c9b5f399f::sexy {
    struct SEXY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEXY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<SEXY>(arg0, 6, b"SEXY", b"SEXY USD", b"SEXY USD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.svgrepo.com/show/404138/smiling-face-with-sunglasses.svg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEXY>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEXY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<SEXY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

