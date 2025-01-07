module 0x71e03d4ef774d0444a0e26c2631c499347399ee6c7539e9f5e9a431a89e49480::vodka {
    struct VODKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: VODKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VODKA>(arg0, 6, b"VODKA", b"Sui Vodka", x"5374696c6c206472696e6b696e672077617465723f200a5768792c2062726f3f0a4472696e6b2024564f444b4120696e737465616421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052039_cfd27b3a12.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VODKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VODKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

