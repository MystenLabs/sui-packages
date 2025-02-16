module 0xb7ae7c4184d69d85b493c5422be34cf1b7679624e6efed602dcc4abd0b94c9af::nu {
    struct NU has drop {
        dummy_field: bool,
    }

    fun init(arg0: NU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NU>(arg0, 9, b"NU", b"Nubi", b"Utility of life coin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9c9e071b-fc47-4fb7-a593-504884d7e973.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NU>>(v1);
    }

    // decompiled from Move bytecode v6
}

