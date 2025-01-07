module 0xa2210fe6615469050e0c0af30717eed692201e74fcc4cdc719a4d4c1a537e621::soralinu {
    struct SORALINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SORALINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SORALINU>(arg0, 6, b"SORALINU", b"BULLSoral", b"The best SORALINU in 2024", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bruh_d1c4a21849.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SORALINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SORALINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

