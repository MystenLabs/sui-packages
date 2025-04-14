module 0xc8472314feaeb60048d39bcd0c90674463d6c05973ad30793fe2562e3b42571e::gltch {
    struct GLTCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLTCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLTCH>(arg0, 9, b"GLTCH", b"GlitchyToken", x"456d627261636520746865206368616f732e20474c54434820697320616e206578706572696d656e74616c2c20756e7072656469637461626c6520746f6b656e207468617420627265616b7320747261646974696f6e616c20746f6b656e6f6d6963732e2052756c65732073686966742c2072657761726473206d75746174652c20766f6c6174696c6974792069732062616b656420696e2e20497427732063727970746f20666f72207468652062726176652c2077656972642c20616e6420776f6e64657266756c6c7920676c69746368792e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/02bbbeafde4137d2073e5b0bd839818ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GLTCH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLTCH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

