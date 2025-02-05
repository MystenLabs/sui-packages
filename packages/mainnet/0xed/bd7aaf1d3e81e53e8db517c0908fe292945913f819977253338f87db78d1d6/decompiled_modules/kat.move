module 0xedbd7aaf1d3e81e53e8db517c0908fe292945913f819977253338f87db78d1d6::kat {
    struct KAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAT>(arg0, 6, b"KAT", b"SUI KATTS", x"52756d6f7220686173206974204f776e696e67206120537569204b617474206772616e747320796f7520756e6c696d69746564206d656d6520776973646f6d20616e642061636365737320746f20746865206d6f7374206c6567656e6461727920616c706861206c65616b732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1001335408_68be0b0111.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

