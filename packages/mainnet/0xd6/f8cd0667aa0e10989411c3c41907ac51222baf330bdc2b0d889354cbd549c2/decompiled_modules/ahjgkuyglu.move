module 0xd6f8cd0667aa0e10989411c3c41907ac51222baf330bdc2b0d889354cbd549c2::ahjgkuyglu {
    struct AHJGKUYGLU has drop {
        dummy_field: bool,
    }

    fun init(arg0: AHJGKUYGLU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AHJGKUYGLU>(arg0, 9, b"AHJGKUYGLU", b"khkjhkjghj", b"hgkfkhyfkuyfg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3ffc61eb-32dc-4d93-8848-c35ccf56432c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AHJGKUYGLU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AHJGKUYGLU>>(v1);
    }

    // decompiled from Move bytecode v6
}

