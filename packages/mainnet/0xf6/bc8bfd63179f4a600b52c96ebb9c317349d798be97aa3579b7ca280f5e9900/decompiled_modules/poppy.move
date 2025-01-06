module 0xf6bc8bfd63179f4a600b52c96ebb9c317349d798be97aa3579b7ca280f5e9900::poppy {
    struct POPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPPY>(arg0, 6, b"POPPY", b"Poppy the hippo", x"5361792068656c6c6f20746f20506f70707921200a0a4d6f7265207468616e203130302c3030302070656f706c652066726f6d2061726f756e642074686520776f726c6420766f74656420746f206e616d6520746865206261627920686970706f20726563656e746c7920626f726e20617420746865204d6574726f20526963686d6f6e64205a6f6f2e204d6f7265207468616e2068616c662063686f736520506f7070792e0a0a22486572206e616d65206973206120666c6f776572206a757374206c696b6520686572206d6f746865722c20497269732c222061207a6f6f2073706f6b6573706572736f6e20736169642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250107_020956_855_e4d108d654.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

