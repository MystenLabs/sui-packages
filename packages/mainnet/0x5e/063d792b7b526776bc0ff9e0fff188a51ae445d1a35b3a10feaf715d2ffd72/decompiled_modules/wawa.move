module 0x5e063d792b7b526776bc0ff9e0fff188a51ae445d1a35b3a10feaf715d2ffd72::wawa {
    struct WAWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAWA>(arg0, 6, b"WAWA", b"WAWA CAT", x"576879206469642074686520736e65616b79205761776120636174206a756d7020696e746f202477617761203f0a53617720746865206d61726b657420626f756e636520616e6420736169642c20225741414141574141414141414141220a486973736564206174204655442c2068656c6420746967687420746f2069747320247761776120626167732e0a446976657273696669656420696e746f2024776177612c2024776177612c20616e642024776177612e0a4e6f77206974206c6f756e67657320666f72776172642c20736d756720616e6420756e626f74686572656420210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_16_19_24_35_059c96119f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAWA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAWA>>(v1);
    }

    // decompiled from Move bytecode v6
}

