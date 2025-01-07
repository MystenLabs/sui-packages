module 0xa5e62ff55298a676290f01920e82fe3e560c2d9adba2e3e3ecf13e485f00dc9e::maga {
    struct MAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGA>(arg0, 6, b"MAGA", b"I'm not just MAGA, I'm dark MAGA", x"417320796f752063616e207365652c2049276d206e6f74206a757374204d4147412c2049276d206461726b204d4147412e0a492077616e7420746f20736179207768617420616e20686f6e6f7220697420697320746f20626520686572652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9_Gk8hb_Kx_400x400_0cc4d8b6ca.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

