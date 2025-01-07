module 0xdb35116440c2f8c154cab5bf4fb31f6383602e1eef3fcc81fb65cfbf6a39184a::dd {
    struct DD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DD>(arg0, 9, b"DD", b"Don don", b"Token of the future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/11329511-2f9e-4105-a6a2-bcc8d7818e3e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DD>>(v1);
    }

    // decompiled from Move bytecode v6
}

