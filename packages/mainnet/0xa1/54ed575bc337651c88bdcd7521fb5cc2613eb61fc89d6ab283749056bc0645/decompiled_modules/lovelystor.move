module 0xa154ed575bc337651c88bdcd7521fb5cc2613eb61fc89d6ab283749056bc0645::lovelystor {
    struct LOVELYSTOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOVELYSTOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOVELYSTOR>(arg0, 9, b"LOVELYSTOR", b"Maimah ", b"Maimah is an acronym that stands for Maimunatu and Ahmad ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eaaae920-cfb4-4caa-b3b6-9939469aecc3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOVELYSTOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOVELYSTOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

