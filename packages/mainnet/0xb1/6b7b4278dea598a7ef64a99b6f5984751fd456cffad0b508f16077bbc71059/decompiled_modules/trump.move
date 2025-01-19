module 0xb16b7b4278dea598a7ef64a99b6f5984751fd456cffad0b508f16077bbc71059::trump {
    struct TRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP>(arg0, 6, b"TRUMP", b"OFFICIAL TRUMP SUI", x"546865204f6666696369616c205472756d70204d656d6520436f696e206f6e2053756920697320666173742c206c6f772d6665652c20616e64206d656d652d706f77657265642063727970746f2063656c6562726174696e6720746865204d414741206d6f76656d656e742e204275696c74206f6e20537569e2809973207363616c61626c6520626c6f636b636861696e2c206974e2809973206120626f6c642073746174656d656e74206f662066726565646f6d20616e6420646563656e7472616c697a6174696f6e2e204275792c20484f444c2c20616e64206a6f696e20746865206d6f76656d656e7421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737294599072.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

