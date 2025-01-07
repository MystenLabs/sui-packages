module 0xed4050a6482cffe67cd5b6bc6708ae7d584cc5ea371d1c29cef7d820e106652b::ronda {
    struct RONDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RONDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RONDA>(arg0, 6, b"RONDA", b"Ronda On Sui", x"4d65657420526f6e64612e205468652046697273742042696c6c696f6e20446f6c6c617220446f67204f6e20537569210a0a57652061696d20746f2063726561746520612076696272616e7420636f6d6d756e6974792061726f756e6420526f6e64612c20776865726520696e766573746f72732063616e206c6561726e2c2073686172652c20616e6420696e7665737420696e206f7572206d656d6520636f696e2070726f6a656374207768696c6520656e6a6f79696e672074686520706c617966756c20737069726974206f6620526f6e646120616e642068657220616476656e74757265732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ronda_89940553e1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RONDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RONDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

