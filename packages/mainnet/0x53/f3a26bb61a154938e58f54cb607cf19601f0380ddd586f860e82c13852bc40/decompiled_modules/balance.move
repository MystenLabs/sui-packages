module 0x53f3a26bb61a154938e58f54cb607cf19601f0380ddd586f860e82c13852bc40::balance {
    struct BALANCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALANCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALANCE>(arg0, 6, b"Balance", b"Yin Yang", x"466f7220616c6c207468617420697320676f6f6420616e6420706561636566756c20696e2074686520776f726c64210a46616972206c61756e63682c204e6f207465616d20616c6c6f636174696f6e210a4d617920616c6c206f66207573207072657661696c21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_6111f9cc20.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALANCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALANCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

