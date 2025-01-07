module 0x396bc1cca0ffdcefd9f46d52fe5cec4100bd7a175b14a34e1de9074203af272::emon {
    struct EMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMON>(arg0, 6, b"EMON", b"EasyMoon", x"45617379206d6f6f6e2069732074686520666173746573742077617920746f2067657420746f20746865206d6f6f6e21210a0a536f6c696420636f6d6d6f6e20776974682061206661697220646973747269627574696f6e206c61756e63680a446f204e6f742053656c6c20796f757220636f696e73206265666f7265207265616368696e67206f75722064657374696e6174696f6e20312062696c6c696f6e206d61726b6574206361702120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000119467_6a899ab1d2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EMON>>(v1);
    }

    // decompiled from Move bytecode v6
}

