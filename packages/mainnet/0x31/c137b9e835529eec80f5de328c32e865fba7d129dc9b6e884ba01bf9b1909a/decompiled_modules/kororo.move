module 0x31c137b9e835529eec80f5de328c32e865fba7d129dc9b6e884ba01bf9b1909a::kororo {
    struct KORORO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KORORO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<KORORO>(arg0, 6, b"KORORO", b"Kokoro  by SuiAI", x"54686520756c74696d61746520706c6174666f726d20746f2063726561746520796f7572206f776e206167656e74206f6e2074686520537569206e6574776f726b20717569636b6c792c20656173696c792c20616e64207365637572656c792e20f09f9ba02057697468204b4f4b4f524f2c20796f752063616e20756e6c6f636b207468652066756c6c20706f74656e7469616c206f6620626c6f636b636861696e20746563686e6f6c6f67792062792064657369676e696e6720616e64206d616e6167696e6720756e69717565206167656e7473207468617420696e746572616374207365616d6c6573736c792077697468696e20746865205375692065636f73797374656d2e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/of_Fa_Nilk_400x400_4b9d2f6873.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KORORO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KORORO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

