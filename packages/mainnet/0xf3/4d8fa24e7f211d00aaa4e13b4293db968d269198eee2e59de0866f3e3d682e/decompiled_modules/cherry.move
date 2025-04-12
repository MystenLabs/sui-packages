module 0xf34d8fa24e7f211d00aaa4e13b4293db968d269198eee2e59de0866f3e3d682e::cherry {
    struct CHERRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHERRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHERRY>(arg0, 6, b"CHERRY", b"Cherry Sui", b"Cherry is a famous meme on the sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000056698_1b9ec9a087.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHERRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHERRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

