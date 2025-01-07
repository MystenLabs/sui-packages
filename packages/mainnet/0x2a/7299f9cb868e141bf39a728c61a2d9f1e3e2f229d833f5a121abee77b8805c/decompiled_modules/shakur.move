module 0x2a7299f9cb868e141bf39a728c61a2d9f1e3e2f229d833f5a121abee77b8805c::shakur {
    struct SHAKUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHAKUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHAKUR>(arg0, 6, b"Shakur", b"2Pac", x"4c696b6520612070686f656e69782066726f6d207468652061736865732c20696e6469676e616e7420616e642064657465726d696e65642c20746865206b696e6720726f736520746f207265636c61696d2074686520776f726c642074686174206f6e63652062656c6f6e67656420746f2068696d2e205468652070656f706c6520776570742077697468206a6f792c20666f72207468657920636f756c642073656520616e6420686561722068696d2e204c6f6e67206c69766520746865206b696e670a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/45dc32a3_d826_4e2f_a87a_2dc1abae7917_a2274b5b0b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHAKUR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHAKUR>>(v1);
    }

    // decompiled from Move bytecode v6
}

