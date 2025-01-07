module 0x5947e8fe8685817b2158819529528d25db8f1043ee0c173da4b9accce6a9fb09::rayzzz {
    struct RAYZZZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAYZZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAYZZZ>(arg0, 6, b"RAYZZZ", b"Ray on sui", b"The $Ray that smokes under the water. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/F6_19j0_K_400x400_ca86fa9ade.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAYZZZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAYZZZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

