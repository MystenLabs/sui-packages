module 0xb9e1b9d79ef646e65073ecd4b24a873acf26e2f2df988dcb60689dafc4e47ae6::bln {
    struct BLN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLN>(arg0, 6, b"BLN", b"BALON", b"BALON KAPADOKYA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/istockphoto_1297349747_612x612_588bf074f4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLN>>(v1);
    }

    // decompiled from Move bytecode v6
}

