module 0x4bbdf804d83cb4bdfe2a38388fa3c2142d35af6e21b22e2f7dba26f0a8bbaa1b::chillfamily {
    struct CHILLFAMILY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLFAMILY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLFAMILY>(arg0, 6, b"CHILLFAMILY", b"Just a CHILLFAMILY", b"Just a chillfamily", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/chill_family_ae4e10a401.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLFAMILY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLFAMILY>>(v1);
    }

    // decompiled from Move bytecode v6
}

