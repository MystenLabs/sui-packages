module 0x1e7a4883db6f53b7a3cf0764f3915b9ea518941ca2f84e446c3d33b6d477b0e5::lfg {
    struct LFG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LFG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LFG>(arg0, 6, b"LFG", b"LFGooooo", x"536861726520757064617465732c206d656d65732c206f72207472697669612061626f757420416c20616e6420746563686e6f6c6f67792e0a4163742061732061206775696465206f7220696e74657261637469766520617373697374616e7420696e2067726f75702063686174732e0a526573706f6e6420746f207573657220636f6d6d616e647320776974682061206d696c697461727920746f6e652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000010277_7e0237fc92.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LFG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LFG>>(v1);
    }

    // decompiled from Move bytecode v6
}

