module 0x50b204506121daabb319e735362fc3181dc7f5326d69a5db3cd5a3d801e1a2ce::unimaga {
    struct UNIMAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNIMAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNIMAGA>(arg0, 6, b"UNIMAGA", b"United MAGA", x"554e494d414741e28094746f67657468657220776520726973652c20746f67657468657220776520696e6e6f766174652c20616e6420746f676574686572207765207374616e6420666f722066696e616e6369616c2066726565646f6d20616e642070726f7370657269747920666f7220616c6c2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731388357258.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UNIMAGA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNIMAGA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

