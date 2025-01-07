module 0x41d1d2182216a4c95e31982eb199c041399477ac673e74773a9dc35a5b53a859::deep {
    struct DEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEP>(arg0, 6, b"DEEP", b"DeepBook Token v3", b"The backbone of Sui just upgraded. the v3 GemPool is a layer to the original protocol that allows for static rewards. Just hold and watch it grow.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_6539fa03c3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

