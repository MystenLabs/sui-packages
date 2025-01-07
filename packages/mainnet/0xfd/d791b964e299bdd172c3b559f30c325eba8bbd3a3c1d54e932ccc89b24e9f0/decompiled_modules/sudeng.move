module 0xfdd791b964e299bdd172c3b559f30c325eba8bbd3a3c1d54e932ccc89b24e9f0::sudeng {
    struct SUDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUDENG>(arg0, 6, b"SuDENG", b"Moo-Deng on Sui", b"Baby hippo, moo deng ^.^ ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_cb5ca284bf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

