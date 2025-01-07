module 0x196444001d2daad59202fa4915fe249191e319e31a93f9a26a9ac5caee984f02::abwaham {
    struct ABWAHAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABWAHAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABWAHAM>(arg0, 6, b"ABWAHAM", b"Abwaham Winkin", x"4162776168616d204c696e636f6c6e2069732061200a0a66616d696c79206f6e20536f6c616e612e2057652772650a0a6865726520746f20737072656164206d656d65732c0a0a676f6f642076696265732c20616e6420626f6e64200a0a6f766572206f7572206c6f766520666f7220746865200a0a7472656e636865732e204a6f696e207468652066616d696c790a0a616e64206c65747320686176652066756e200a0a6d616b696e672062616e6b212020", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048993_5df6694533.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABWAHAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ABWAHAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

