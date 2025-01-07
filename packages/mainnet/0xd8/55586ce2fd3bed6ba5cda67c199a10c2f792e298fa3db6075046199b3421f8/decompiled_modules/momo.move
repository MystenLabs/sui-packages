module 0xd855586ce2fd3bed6ba5cda67c199a10c2f792e298fa3db6075046199b3421f8::momo {
    struct MOMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<MOMO>(arg0, 9, b"MOMO", b"MOMO Token", b"MOMO Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file.walletapp.waveonsui.com/logos/wewe.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOMO>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOMO>>(v0, @0x488ba7d35f807b11f0915ac6ae9cac053f7bdebc137e45769b7a8bc0de23428e);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<MOMO>>(v1, @0x488ba7d35f807b11f0915ac6ae9cac053f7bdebc137e45769b7a8bc0de23428e);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MOMO>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MOMO>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

