module 0xf50b7940dee3ddfe531c3f8316425ca41e84bdee94b2c8cafc357ecaaab99597::dawgz {
    struct DAWGZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAWGZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAWGZ>(arg0, 6, b"Dawgz", b"Suiweed Dawgz", x"2257656c636f6d6520746f20746865205355497765656420446177677a20687562202077686572652063727970746f206d656574732063756c747572652e204578706c6f726520746865206c617465737420757064617465732c20636f6d6d756e69747920696e6974696174697665732c20616e642067726f756e64627265616b696e672066656174757265732061732077652067726f7720746865205355497765656420446177677a2065636f73797374656d2e20537461792074756e656420666f72206d6f726521220a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000017603_a527bcafea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAWGZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAWGZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

