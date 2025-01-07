module 0x24d6ad1b9bff405c6610370912c11308aef32295ec602b850529546f6cab0ba1::nami {
    struct NAMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAMI>(arg0, 9, b"NAMI", b"SUINAMI ", x"5355494e414d49202220697320612066756e20616e6420696e6e6f766174697665206d656d652063727970746f63757272656e63792064657369676e656420746f206174747261637420746865206d656d6520616e64206469676974616c2063757272656e637920636f6d6d756e6974792e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d7ddec9f-83ef-4d02-9b8f-a53a6f0eb00f-IMG_7395_2_123d3c8b60.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

