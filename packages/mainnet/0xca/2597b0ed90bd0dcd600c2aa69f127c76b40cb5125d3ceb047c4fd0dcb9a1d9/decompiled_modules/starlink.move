module 0xca2597b0ed90bd0dcd600c2aa69f127c76b40cb5125d3ceb047c4fd0dcb9a1d9::starlink {
    struct STARLINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: STARLINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STARLINK>(arg0, 6, b"Starlink", b"Starlink Token", x"496e20612067616c617879206f662070726f6a656374732c2023537461726c696e6b206973207468652073686f6f74696e6720737461722120200a57657265206272696e67696e6720746f676574686572206d656d657320616e64207265616c2d776f726c64206170706c69636174696f6e7320746f206c69676874207468652077617920666f7220746865206e6578742067656e65726174696f6e206f6620646563656e7472616c697a6564206e6574776f726b732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/STARLINK_49ca066e94.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STARLINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STARLINK>>(v1);
    }

    // decompiled from Move bytecode v6
}

