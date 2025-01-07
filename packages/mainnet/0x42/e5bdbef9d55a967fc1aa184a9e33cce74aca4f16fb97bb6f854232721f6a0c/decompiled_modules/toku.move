module 0x42e5bdbef9d55a967fc1aa184a9e33cce74aca4f16fb97bb6f854232721f6a0c::toku {
    struct TOKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKU>(arg0, 6, b"TOKU", b"SUITOKU", x"546f6b752069732074686520776f726c64277320666972737420616e64206f6e6c7920646f67206465762c2064657465726d696e656420746f207265766f6c7574696f6e697a6520746865206d656d6520696e6475737472792e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/az5_VG_25e_400x400_3a1e7b8f74.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

