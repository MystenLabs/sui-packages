module 0xbcfb8e54ef44ee2e0fde96796529a81dfd1e7ef55df55fd656d4fa7e48a109fc::don {
    struct DON has drop {
        dummy_field: bool,
    }

    fun init(arg0: DON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DON>(arg0, 6, b"DON", b"The Nutfather", x"596f757265206569746865722077697468207468652066616d696c79206f7220616761696e7374207468652073746173682e0a446f6e74206d697373206f7574206f6e20746865206d6f7374206e75746f72696f7573206d656d65636f696e20696e207468652067616d652e20546865204e7574666174686572206177616974732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2025_01_17_00_19_33_b6f64fba16.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DON>>(v1);
    }

    // decompiled from Move bytecode v6
}

