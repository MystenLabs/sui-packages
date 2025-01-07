module 0x8a344783b8c768ff5f1aac852e1bf40addc878acdab0baedacef255823996dc4::sah {
    struct SAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAH>(arg0, 9, b"SAH", b"songanh", b"SHA token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/41e2c0e0-e84b-415f-8cad-98270aafb811.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAH>>(v1);
    }

    // decompiled from Move bytecode v6
}

