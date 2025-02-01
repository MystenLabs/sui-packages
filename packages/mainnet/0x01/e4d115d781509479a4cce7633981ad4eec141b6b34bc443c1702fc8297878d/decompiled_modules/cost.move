module 0x1e4d115d781509479a4cce7633981ad4eec141b6b34bc443c1702fc8297878d::cost {
    struct COST has drop {
        dummy_field: bool,
    }

    fun init(arg0: COST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COST>(arg0, 6, b"COST", b"COSTCO", x"496e74726f647563696e6720436f7374636f20436f696e202824434f535429202041206e657720657261206f662076616c756520616e6420636f6d6d756e69747921200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250202_021441_497_5f1aeab1c3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COST>>(v1);
    }

    // decompiled from Move bytecode v6
}

