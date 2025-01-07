module 0x43b044a696da789e9f18342411e49fdbaf5675159b8cc4ca2ee8a75d5d636b98::fatcat {
    struct FATCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FATCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FATCAT>(arg0, 9, b"FATCAT", b"Fat Cat", b"World fastest cat on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/93fbfdc7-4945-4c86-821d-6d75ad3c41c2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FATCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FATCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

