module 0x9da3f9a8f23c1318f3dbd1961611f20b18332d412ce96b66dac6ef65c917ff9a::doreamon {
    struct DOREAMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOREAMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOREAMON>(arg0, 9, b"DOREAMON", b"DOMON", b"NOTHING", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e34c263f-748e-4bd2-bf90-441c7463d0b9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOREAMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOREAMON>>(v1);
    }

    // decompiled from Move bytecode v6
}

