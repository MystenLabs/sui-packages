module 0x808701235529bdeb389c29a4515297a99fc459cc02f8edd87eb66f0d527729ee::fine {
    struct FINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FINE>(arg0, 6, b"FINE", b"sui is fine.", b"im fine.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_is_fine_aec4bc348b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

