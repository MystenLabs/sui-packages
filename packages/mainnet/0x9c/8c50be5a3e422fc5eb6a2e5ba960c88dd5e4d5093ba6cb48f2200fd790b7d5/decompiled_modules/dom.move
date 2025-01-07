module 0x9c8c50be5a3e422fc5eb6a2e5ba960c88dd5e4d5093ba6cb48f2200fd790b7d5::dom {
    struct DOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOM>(arg0, 6, b"DOM", b"DOMS", b"DOMS is the only music PFP on sui and now has a TOKEN $DOM ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f5wtve_MG_400x400_3ada06ad10.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

