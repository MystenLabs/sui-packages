module 0xc2d1721aac07d93a16b6e0c66d80ef38684b977c9c3572da1bd3ffaf3a65a222::moth {
    struct MOTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOTH>(arg0, 6, b"MOTH", b"MOTHSUI", b"$MOTH comes to the bright lights of SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/billy_3699a2f9a0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOTH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOTH>>(v1);
    }

    // decompiled from Move bytecode v6
}

