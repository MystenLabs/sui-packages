module 0xf6277fd58669a2db145bc5aa76f15883d08cddc53a5842aa79d994256b2fc038::waka {
    struct WAKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAKA>(arg0, 9, b"WAKA", b"Waka", b"WAKA WAKA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0aa5f240-68c0-475e-a3da-a07ca096180c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

