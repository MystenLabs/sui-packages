module 0x562fd576f1c4ba1686b6ffa3614583d75b092b3801ea8e132803a0f162a4f7dc::brocc {
    struct BROCC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROCC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROCC>(arg0, 6, b"BROCC", b"BROCCOLI'S CZ DOG", x"42726f63636f6c6927732053746f72790a0a41207965617220616e6420612068616c662061676f2c20492063617375616c6c7920636861747465642077697468206120667269656e642077686f206f776e6564206120287265616c29207a6f6f20696e2044756261692e20437572696f75732c20492061736b6564207768617420646f67206272656564206973206164617074656420746f207468652044756261692073756d6d657220686561742e204920686164206e6f20706c616e7320746f20676574206120646f672e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1739486897024.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BROCC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROCC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

