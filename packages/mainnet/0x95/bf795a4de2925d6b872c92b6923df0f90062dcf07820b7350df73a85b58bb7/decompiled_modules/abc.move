module 0x95bf795a4de2925d6b872c92b6923df0f90062dcf07820b7350df73a85b58bb7::abc {
    struct ABC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABC>(arg0, 6, b"ABC", b"Abc", b"qvcc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1748515018122.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ABC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

