module 0xca6af5402aa8a243fc2a6740cf31e8cc46402102af535c53092895733f769851::pki {
    struct PKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PKI>(arg0, 9, b"PKI", b"PISHI", b"THE CAT AND THE THREE LITTLW HEADS ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4ca35d46-e4eb-464f-8475-c04a85430560.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

