module 0x4c8f0ce0b8d7029d4cd239c7634b1bbf49182af080438c91cae27a1441b091a3::fox {
    struct FOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOX>(arg0, 9, b"FOX", b"fox", b"fox is a fox.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a2b52fb8-4094-4e7f-86ab-7b8da7f82196.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOX>>(v1);
    }

    // decompiled from Move bytecode v6
}

