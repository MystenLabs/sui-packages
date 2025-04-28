module 0xe592c3b79c0fe506253c96027e86d72894438ce7291be02ea194ad9cc3751e46::suinic {
    struct SUINIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINIC>(arg0, 6, b"SUINIC", b"SUINIC SUI", b"Suinic moon, no pepe moon Suinic moon today i s a Suinic da y toda i Suinic moon. yes Suinic go to da moon. u is cuming wif Suinic?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_29_13_31_08_1_302f75d16c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

