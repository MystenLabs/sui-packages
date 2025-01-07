module 0xe31747185bf3f000b8839868bde3948bd15cbbfee8810f833b3b3243b2322635::mk {
    struct MK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MK>(arg0, 9, b"MK", b"MemeKombat", b"Meme Fighter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3ebf95dc-f085-4b7c-a192-2934bf6156f8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MK>>(v1);
    }

    // decompiled from Move bytecode v6
}

