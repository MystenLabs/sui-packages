module 0x6c3ab2551b36bb9d9ee3e751693e89343db30ab7ccec1cbec0c4fb0f8355fff2::suiwif {
    struct SUIWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWIF>(arg0, 6, b"SUIWIF", b"SUIdogewifHat", b"SUIdogewifHat is a cool version of Doge, rocking a blue beanie because it's on the SUI network. This stylish Doge knows crypto and fashion, showing that even in blockchain, swag matters!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wif_fabd8756c6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

