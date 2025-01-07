module 0xf885824792e36c3ea54850951e0ffb350ad7df252b34746c868505d3debb2c5a::brotherpnu {
    struct BROTHERPNU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROTHERPNU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROTHERPNU>(arg0, 9, b"BROTHERPNU", b"Wally ", x"546869732070726f6a6563742068617320696e6372656469626c6520766973696f6e20616e6420706f74656e7469616c3b206974e2809973206120636f6d6d756e697479206566666f727420796f7520646f6ee28099742077616e7420746f206d69737321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8e54db40-78c3-4fec-a1c8-55e316b49733.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROTHERPNU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BROTHERPNU>>(v1);
    }

    // decompiled from Move bytecode v6
}

