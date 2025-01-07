module 0x24929f5969aa1191f5395334be00da51c66a666e5fe01d3fad95f157549673b0::moth {
    struct MOTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOTH>(arg0, 6, b"MOTH", b"MOTH ON SUI", b"$MOTH comes to the bright lights of SUI !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/billy_909e80dbf1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOTH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOTH>>(v1);
    }

    // decompiled from Move bytecode v6
}

