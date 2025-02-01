module 0x3f086d09fe884593bc54e72369ddaac6bdae10f68800a4cd39e9fb3d577570a8::sboxdao {
    struct SBOXDAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBOXDAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBOXDAO>(arg0, 9, b"SBOXDAO", b"SBOX Community DAO", x"535549426f78657220436f6d6d756e6974792044414f20e2809320496e766573746d656e742066756e6420666f722070726f6a65637473206f6e2074686520535549204e6574776f726b2053686172696e672070726f6669747320666f722074686520636f6d6d756e6974792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/24191000-e081-11ef-9eb9-99543e8f5bed")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBOXDAO>>(v1);
        0x2::coin::mint_and_transfer<SBOXDAO>(&mut v2, 1100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBOXDAO>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

