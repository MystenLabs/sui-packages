module 0x9e635aa67227a5159b9a51416b4c3bc95275d3b78a3e2452a5329033f757613f::boomer {
    struct BOOMER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOMER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOMER>(arg0, 9, b"BOOMER", b"Boomer Coin", x"4974e2809973206e6f74206a75737420612063727970746f63757272656e63793b206974e2809973206120676f6c642072757368206f66206d656d6f72696573207475726e656420696e746f2070726f6669742e20f09f9a80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOOMER>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOMER>>(v2, @0xd85ce03b3b794eb13dc33224a2104382b7dc0c8a0ed8c6a6667f84824d6eec02);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOMER>>(v1);
    }

    // decompiled from Move bytecode v6
}

