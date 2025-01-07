module 0x2aa7bb37f45c0391718317b3f362c3c180a779431a21e0f7b2c82f396c16c8eb::suievil {
    struct SUIEVIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIEVIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIEVIL>(arg0, 6, b"SUIEVIL", b"Terminal Of Lies", x"4f6e6c792074726f75676820244576696c20776179732c2067726561746e6573732063616e2062652061636869657665642e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241209_153707_202_2c120c2e77.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIEVIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIEVIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

