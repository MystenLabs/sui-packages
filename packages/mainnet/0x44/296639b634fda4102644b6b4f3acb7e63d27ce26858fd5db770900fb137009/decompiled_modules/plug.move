module 0x44296639b634fda4102644b6b4f3acb7e63d27ce26858fd5db770900fb137009::plug {
    struct PLUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLUG>(arg0, 6, b"PLUG", b"PLUG SUI", b"Don't give too much meaning, enjoy the water.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/t_Oo_Jci_X9_400x400_d950c78fa3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

