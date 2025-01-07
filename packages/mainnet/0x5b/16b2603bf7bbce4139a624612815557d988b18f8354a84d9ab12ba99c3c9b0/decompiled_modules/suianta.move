module 0x5b16b2603bf7bbce4139a624612815557d988b18f8354a84d9ab12ba99c3c9b0::suianta {
    struct SUIANTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIANTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIANTA>(arg0, 6, b"SUIANTA", b"SUI SANTA", x"535549414e544120495320484552450a0a5468652053554920626c6f636b636861696e20697320736f6172696e6720746f206e657720686569676874732c2065766f6c76696e6720666173746572207468616e20657665722c20616e6420636c696d62696e6720737472616967687420746f2074686520746f7021200a0a5768657468657220796f75277665206265656e206e617567687479206f72206e6963652c20535549414e5441206973206272696e67696e6720796f752061206c6974746c652063727970746f206d61676963207468697320736561736f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733912222166.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIANTA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIANTA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

