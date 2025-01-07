module 0x6eed50d97a1dee9744b88a96606b02ce05153452f3d98c5b2b04e6cbed162380::ethereum {
    struct ETHEREUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETHEREUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETHEREUM>(arg0, 6, b"Ethereum", b"Eth", b"Clsico  ethereum bsico    mantener tokens $$$$$$$$$$$$$$$", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001315_85bb09d8b9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETHEREUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ETHEREUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

