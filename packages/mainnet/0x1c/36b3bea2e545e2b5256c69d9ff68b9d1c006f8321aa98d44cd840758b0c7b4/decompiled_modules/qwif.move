module 0x1c36b3bea2e545e2b5256c69d9ff68b9d1c006f8321aa98d44cd840758b0c7b4::qwif {
    struct QWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: QWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QWIF>(arg0, 6, b"QWIF", b"quokka wif hat", b"send it to dog wif mc and shock all the crypto community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Image_2e96f5baa9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

