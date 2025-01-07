module 0xd5328020b57ec530cf68669d638d73cdafc0ef1767f9eac7e7eca65df3b4c069::pki {
    struct PKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PKI>(arg0, 9, b"PKI", b"PISHI", b"THE CAT AND THE THREE LITTLW HEADS ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/23c7c3e5-5d3f-4e6f-916e-c1cf47acbf33.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

