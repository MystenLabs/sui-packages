module 0x29ecc27d2ebbfacb0aafbae1ae744e756a4f34bcdda951a9e606959d8288a57d::durov {
    struct DUROV has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUROV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUROV>(arg0, 9, b"DUROV", b"Bones", b"Durov Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9bf4e199-b921-486f-88d9-a0d172623e0a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUROV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUROV>>(v1);
    }

    // decompiled from Move bytecode v6
}

