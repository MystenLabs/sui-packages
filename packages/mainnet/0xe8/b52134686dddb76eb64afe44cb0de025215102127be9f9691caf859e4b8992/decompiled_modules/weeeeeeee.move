module 0xe8b52134686dddb76eb64afe44cb0de025215102127be9f9691caf859e4b8992::weeeeeeee {
    struct WEEEEEEEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEEEEEEEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEEEEEEEE>(arg0, 9, b"WEEEEEEEE", b"Weee", b"Weeeeeeeeeeee", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7ae6c70f-bb39-4eb8-96ff-3882535c2bfe-IMG_20241005_112656.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEEEEEEEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEEEEEEEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

