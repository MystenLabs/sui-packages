module 0x2f9a0d06668dd24999f1aa99603b55df2e277823bfa6497ec496a90dc3b4a81b::tinytitan {
    struct TINYTITAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TINYTITAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TINYTITAN>(arg0, 6, b"TINYTITAN", b"TINY TITAN TOKEN", x"496e74726f647563696e672054696e79546974616e20546f6b656e21200a0a496e2074686520646570746873206f6620746865206f6365616e2c2061206c6567656e64617279206372656174757265206c75726b732c2066656172656420627920616c6c2077686f206477656c6c20696e20697473207265616c6d2e205769746820636c617773206f66206c696768746e696e6720616e642065796573206f66207468756e6465722c20746865204d616e74697320536872696d7020726973657320746f20636f6e71756572207468652063727970746f63757272656e637920736561732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000013499_a9ba0b4e87.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TINYTITAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TINYTITAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

