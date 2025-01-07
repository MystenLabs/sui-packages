module 0xcf498d33b6159e53c476b0b7d67bd0036682b56b91c24d72ace6c1c5e0213743::suishib {
    struct SUISHIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHIB>(arg0, 6, b"SUISHIB", b"SuiShib", x"537569736869622069732061206e65772067656e65726174696f6e206d656d65636f696e2074686174206272696e67732074686520737069726974206f6620536869626120746f207468652053756920626c6f636b636861696e20696e20612077617920796f75e280997665206e65766572207365656e206265666f72652120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731047520293.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISHIB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHIB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

