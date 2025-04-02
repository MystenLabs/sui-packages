module 0xd0a64ec6525088502bd070b97d1d72d63efca7c6415b6e990044a95efd1821af::cba {
    struct CBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CBA>(arg0, 9, b"CBA", b"Bac169", b"Vietcamranh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/62769a32219359aca7831f849cec0a40blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CBA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CBA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

