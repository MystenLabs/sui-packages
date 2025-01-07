module 0x22c2b5e42deab702d84bcb5afb54650ebd433ee3883d4f1673bead6d626c3893::knuk {
    struct KNUK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KNUK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KNUK>(arg0, 9, b"KNUK", b"NUKE KING", b"2 Man, 2 Leader, 2 Gamechanger, 2 key, 2 God of Nuke", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6baf23dc-6a95-4db9-b850-1cdd0007b2be.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KNUK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KNUK>>(v1);
    }

    // decompiled from Move bytecode v6
}

