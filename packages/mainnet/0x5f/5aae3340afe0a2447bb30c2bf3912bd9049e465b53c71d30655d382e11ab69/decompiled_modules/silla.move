module 0x5f5aae3340afe0a2447bb30c2bf3912bd9049e465b53c71d30655d382e11ab69::silla {
    struct SILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SILLA>(arg0, 6, b"SILLA", b"SUI BABY GORILLA", x"4d656574202453494c4c41202d20535549204241425920474f52494c4c4121200a0a486520697320726561647920746f20646973636f76657220616c6c2074686520776f6e646572730a61686561642e205769746820657665727920706c617966756c20626f756e63652c20686527730a707265706172696e6720746f206d616b6520686973206d61726b20696e20746865206469676974616c0a6c616e6473636170652c206272696e67696e6720612077686f6c65206e6577206c6576656c206f660a617765736f6d656e65737320746f207468652067616d652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SILLA_20_LOGO_MAIN_1_13aec1e5c5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SILLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SILLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

