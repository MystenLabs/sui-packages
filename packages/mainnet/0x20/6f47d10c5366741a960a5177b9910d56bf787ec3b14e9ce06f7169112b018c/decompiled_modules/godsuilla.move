module 0x206f47d10c5366741a960a5177b9910d56bf787ec3b14e9ce06f7169112b018c::godsuilla {
    struct GODSUILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GODSUILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GODSUILLA>(arg0, 6, b"GODSUILLA", b"GOD-SUI-LLA", x"24676f645355496c6c616973206120707265686973746f7269632072657074696c69616e206f722064696e6f7361757269616e206d6f6e73746572207468617420697320616d70686962696f7573206f722072657369646573207061727469616c6c7920696e20746865205355492c206177616b656e656420616e6420656d706f7765726564206166746572206d616e792079656172732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_03_22_20_01_2d6b7e31fe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GODSUILLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GODSUILLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

