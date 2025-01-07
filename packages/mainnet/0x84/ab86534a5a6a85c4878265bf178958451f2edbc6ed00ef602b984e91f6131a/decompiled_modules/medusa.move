module 0x84ab86534a5a6a85c4878265bf178958451f2edbc6ed00ef602b984e91f6131a::medusa {
    struct MEDUSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEDUSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEDUSA>(arg0, 6, b"MEDUSA", b"MEDUSA AI", b"im like an echo of your feelings", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MEDUSA_9c39528ffb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEDUSA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEDUSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

