module 0xfe057034dd454bc1ec67247b1f51923a94a379650c6baf16e770035d90afdc12::wecat {
    struct WECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WECAT>(arg0, 9, b"WECAT", b"WAWE", b"WAWE is a meme inspired by the spirit of adventure and freedom. With WAWE, we are not just riding the wawes - we are mastering them!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b29cd1a3-60e1-4f9a-aeef-8c8f9e959a89.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WECAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WECAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

