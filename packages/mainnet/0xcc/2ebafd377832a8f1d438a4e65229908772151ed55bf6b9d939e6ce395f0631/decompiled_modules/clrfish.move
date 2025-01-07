module 0xcc2ebafd377832a8f1d438a4e65229908772151ed55bf6b9d939e6ce395f0631::clrfish {
    struct CLRFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLRFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLRFISH>(arg0, 6, b"CLRFISH", b"the colorful fish", b"the only colorful fish in the sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0330_e064f421fe.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLRFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLRFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

