module 0x2fa3b63a2772661e06b05c42d62ab55432080cf284e938c4e7b2ca9b07be5a1f::imblue {
    struct IMBLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: IMBLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IMBLUE>(arg0, 6, b"IMBLUE", b"I'm Blue Da ba dee da ba di", x"546865206d656d65636f696e20746861742074616b657320796f75206261636b20746f20746865203930732c2077686572652065766572797468696e672077617320626c75652120494d424c55452c20496e737069726564206279207468652069636f6e696320747261636b20412044656361646520696e20426c75652028446120426120446565292e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_2e8e5a7fce.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IMBLUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IMBLUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

