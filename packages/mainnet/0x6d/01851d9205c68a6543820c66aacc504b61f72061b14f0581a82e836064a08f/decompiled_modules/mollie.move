module 0x6d01851d9205c68a6543820c66aacc504b61f72061b14f0581a82e836064a08f::mollie {
    struct MOLLIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOLLIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOLLIE>(arg0, 9, b"MOLLIE", b"MOLLIE DE ASCII CRAB", x"54686520756e6f6666696369616c206d6173636f74206f6620552e53204469676974616c20536572766963652068696464656e206f6e2068697320776562736974652e20200d0a0d0a4d656574204d6f6c6c69652074686520637261622c206f757220756e6f6666696369616c206d6173636f74203a290d0a0d0a68747470733a2f2f7777772e757364732e676f762f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQEEbVewjf7ga29yik54kcKRZybQhMmwjmgSbGzJg9sm8")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOLLIE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOLLIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOLLIE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

