module 0x166dc763255e4583f6b29777865c91efb1c1b039117f30e97a876ac8f6c5de58::wqdc {
    struct WQDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: WQDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WQDC>(arg0, 6, b"WQDC", b"WiseQuackerDuckClub", x"57697365205175616b657273204475636b20436c75622e2046756c6c792044696c7574656420436f6d6d756e69747920436f696e2e205574696c697479206f6e6c792e204f70656e20746f2077686f657665722c20666f722077686f657665722c20616e6420646f207768617420796f752077616e742e20436f6d6d756e697479204f776e65642c206e6f2056432e204f6e652072756c6520697320746861742074686572652773206e6f2072756c65732e0a0a4e6f206f6666696369616c20736974652e204e6f20747769747465722e204e6f2074656c656772616d2e204c65742074686520636f6d6d756e697479206465636964652e205171756161636b6b21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wise_Quacker3_0fa4dbf79f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WQDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WQDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

