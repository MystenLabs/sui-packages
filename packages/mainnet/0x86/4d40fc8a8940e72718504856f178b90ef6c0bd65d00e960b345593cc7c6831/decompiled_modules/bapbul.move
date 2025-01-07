module 0x864d40fc8a8940e72718504856f178b90ef6c0bd65d00e960b345593cc7c6831::bapbul {
    struct BAPBUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAPBUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAPBUL>(arg0, 6, b"BAPBUL", b"BAPBUL ON SUI", x"2442415042554c20697320746865206d6f73742063757465202620766972616c20646f67206f6e2074686520696e7465726e65742e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/j4_Y8_O_Lu_400x400_0f6976593d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAPBUL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAPBUL>>(v1);
    }

    // decompiled from Move bytecode v6
}

