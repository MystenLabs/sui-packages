module 0xbd18a538c47690f82bdf104f112323da3369f30213a4dbd0a466931113d6804a::plug {
    struct PLUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLUG>(arg0, 6, b"PLUG", b"PLUG ON SUI", x"596f7527766520676f7420736f6d65206669726520796f752077616e6e6120707574206f75743f0a24504c554720697320676f6e20646f207468617420666f7220796f750a0a456e6a6f792074686520776174657220616e6420646f6e27742062652061667261696420746f2067657420776574200a4772616220736f6d652062616720616e6420676574206f6e207468652072696465", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000460025_9b6a86d666.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

