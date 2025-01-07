module 0x2764704204bb4f27957b24b82877761fe5e53b5215210ea22f86f04b1b6e0f2a::ber {
    struct BER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BER>(arg0, 6, b"BER", b"BER Token", x"4265636f6d652061204265722d6c696576657221205374657020696e746f2074686520776f726c64206f660a426572436f696e20616e6420636f6e6e6563742077697468206120636f6d6d756e69747920746861747320616c6c0a61626f7574206c61756768732c206d656d65732c20616e64206120736861726564206c6f766520666f7220616c6c0a7468696e6773204265722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000005640_f0369a7940.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BER>>(v1);
    }

    // decompiled from Move bytecode v6
}

