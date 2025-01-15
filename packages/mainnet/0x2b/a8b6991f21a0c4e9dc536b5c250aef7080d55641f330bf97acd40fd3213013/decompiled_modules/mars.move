module 0x2ba8b6991f21a0c4e9dc536b5c250aef7080d55641f330bf97acd40fd3213013::mars {
    struct MARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<MARS>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<MARS>(arg0, b"MARS", b"THE MARS 2", b"THE MARS test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/b613e3f0-2b54-4488-8249-af71c838909b")), b"https://science.nasa.gov/mars/", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"009c417625ed9a077bd249b4e90b18f046a9f724ee093643aac74a817391d86e8c86b21f677c0247d27652c4dc9f6b0063fb447edab9559d8efcd01656705a4706f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631736973967"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

