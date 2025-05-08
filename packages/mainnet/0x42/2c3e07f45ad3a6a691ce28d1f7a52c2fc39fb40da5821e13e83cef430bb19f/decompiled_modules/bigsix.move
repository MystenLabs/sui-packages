module 0x422c3e07f45ad3a6a691ce28d1f7a52c2fc39fb40da5821e13e83cef430bb19f::bigsix {
    struct BIGSIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIGSIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIGSIX>(arg0, 9, b"BIGSIX", b"The Big 6", b"$BIGSIX (The Big 6)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://blob.suiget.xyz/uploads/img_681c5976e560b2.03602294.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIGSIX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIGSIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

