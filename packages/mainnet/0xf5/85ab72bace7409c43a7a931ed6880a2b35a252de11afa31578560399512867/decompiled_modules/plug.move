module 0xf585ab72bace7409c43a7a931ed6880a2b35a252de11afa31578560399512867::plug {
    struct PLUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLUG>(arg0, 6, b"PLUG", b"PLUG ON SUI", x"596f7527766520676f7420736f6d65206669726520796f752077616e6e6120707574206f75743f0a24504c554720697320676f6e20646f207468617420666f7220796f750a456e6a6f792074686520776174657220616e6420646f6e27742062652061667261696420746f2067657420776574204772616220736f6d652062616720616e6420676574206f6e207468652072696465", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000460025_03db83ee98.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

