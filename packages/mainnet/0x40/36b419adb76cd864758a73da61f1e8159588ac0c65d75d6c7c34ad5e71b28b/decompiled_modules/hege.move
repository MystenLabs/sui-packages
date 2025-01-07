module 0x4036b419adb76cd864758a73da61f1e8159588ac0c65d75d6c7c34ad5e71b28b::hege {
    struct HEGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEGE>(arg0, 6, b"HEGE", b"HEGE SUI ", b"Join the $HEGE-fund to help unlock new characters and their crazy stories", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731003914528.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

