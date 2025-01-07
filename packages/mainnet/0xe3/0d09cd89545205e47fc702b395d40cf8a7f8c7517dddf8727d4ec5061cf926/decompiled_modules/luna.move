module 0xe30d09cd89545205e47fc702b395d40cf8a7f8c7517dddf8727d4ec5061cf926::luna {
    struct LUNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUNA>(arg0, 6, b"LUNA", b"LUNA CHAN", x"54686973207965617220697320626574746572207468616e206c61737420796561722c206275742069742773207374696c6c20686f7420696e207468652073756d6d657220616e642049276d206120746f756768206d6f6d2e20486176696e67206120666c7566667920646f67206c696b6520244c756e6120697320746f7567680a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_09_23_20_02_17_96ffec4350.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUNA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUNA>>(v1);
    }

    // decompiled from Move bytecode v6
}

