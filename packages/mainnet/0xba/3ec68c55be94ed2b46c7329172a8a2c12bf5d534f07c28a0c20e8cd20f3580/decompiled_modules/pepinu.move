module 0xba3ec68c55be94ed2b46c7329172a8a2c12bf5d534f07c28a0c20e8cd20f3580::pepinu {
    struct PEPINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPINU>(arg0, 6, b"PEPINU", b"Pepe Iu", b"Pepinu is a memecoin on Sui with 0/0 tax on buy and sells. sits alongside its memecoin mates Pepe and Shiba Inu, sparking giggles in the financial playground and makes a lot of millionaires without actually bringing much to the table in terms of practical use.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241111_221742_06972d448b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

