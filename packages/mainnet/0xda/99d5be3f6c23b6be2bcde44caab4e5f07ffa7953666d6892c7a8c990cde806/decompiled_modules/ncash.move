module 0xda99d5be3f6c23b6be2bcde44caab4e5f07ffa7953666d6892c7a8c990cde806::ncash {
    struct NCASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: NCASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NCASH>(arg0, 9, b"NCASH", b"CatnipCash", x"5075727220796f75722077617920746f207765616c74682077697468204361746e697020436173682e20426563617573652077686f20646f65736ee28099742077616e7420612077616c6c65742066756c6c206f66207472656174733f0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/346d4ed3-45b1-4be8-a51d-389137e892ff.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NCASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NCASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

