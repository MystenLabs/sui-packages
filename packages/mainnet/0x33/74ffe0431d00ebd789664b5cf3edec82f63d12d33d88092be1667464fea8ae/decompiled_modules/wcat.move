module 0x3374ffe0431d00ebd789664b5cf3edec82f63d12d33d88092be1667464fea8ae::wcat {
    struct WCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WCAT>(arg0, 9, b"WCAT", b"Wave", b"WAWE is meme inspired by the spirit of adventure and freedom with UAWE, we are not just riding the waves - we are mastering them!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a7a63007-f73d-4c6e-85d4-07e19683aae0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

