module 0x893eae4f317603bf6d65fa6fa97f53d43fa5ee2baad6267ab1e3e3faf4a946ae::panda {
    struct PANDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANDA>(arg0, 6, b"PANDA", b"Panda on Sui", b"Panda to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730950561262.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PANDA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANDA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

