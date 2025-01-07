module 0x94decc1fc47a0f6628c7d6274b4bdef9778931b6cfa4874648725989acf74534::bone {
    struct BONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONE>(arg0, 6, b"BONE", b"Bone", x"426f6e652069732061206d656d65636f696e2074686174206d616b6573206120646966666572656e636520696e2073756920426c6f636b636861696e2077697468206f70656e20736f757263652c20626f6e652077696c6c206d616b65207468652073756920636f6d6d756e69747920687970650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730998728429.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BONE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

