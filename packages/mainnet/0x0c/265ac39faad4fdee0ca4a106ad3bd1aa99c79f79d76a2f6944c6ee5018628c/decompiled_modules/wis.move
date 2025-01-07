module 0xc265ac39faad4fdee0ca4a106ad3bd1aa99c79f79d76a2f6944c6ee5018628c::wis {
    struct WIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIS>(arg0, 6, b"WIS", b"dogwifsui", x"6a757374206120646f677769667375692e0a746720636f6d696e6720736f6f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Capture_da_A_cran_2024_10_09_111400_3573374bcd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

