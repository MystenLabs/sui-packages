module 0x5c66743316b38a62d8333503f6c132c3ef4f26d8362180d46fceec40ee3b6d1c::suishib {
    struct SUISHIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHIB>(arg0, 6, b"SuiShib", b"SUISHIB", x"537569736869622069732061206e65772067656e65726174696f6e206d656d65636f696e2074686174206272696e67732074686520737069726974206f6620536869626120746f207468652053756920626c6f636b636861696e20696e20612077617920796f75e280997665206e65766572207365656e206265666f726521204275696c7420666f722074686f73652077686f206461726520746f20647265616d2062696720616e64207365656b206578636974656d656e7420696e2063727970746f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730997080782.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISHIB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHIB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

