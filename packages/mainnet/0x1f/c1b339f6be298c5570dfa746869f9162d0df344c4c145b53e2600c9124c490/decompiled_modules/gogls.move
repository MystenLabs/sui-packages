module 0x1fc1b339f6be298c5570dfa746869f9162d0df344c4c145b53e2600c9124c490::gogls {
    struct GOGLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOGLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOGLS>(arg0, 6, b"GOGLS", b"Goggles", x"535549204641535420424f492e20544845592053544159204f4e2e0a0a4f6e6c79206f6e205355490a42726f7567687420746f20796f752062792054686520436875726368204f66205370656369616c204e656564732047616d626c6572732e0a544845592053544159204f4e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_73cb23aa79.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOGLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOGLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

