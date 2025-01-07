module 0x64d9b9d80c667f629fa192c7d01225ac49f810434253753f5aec98d31f49721a::sgp {
    struct SGP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGP, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SGP>(arg0, 1232980782569052066, b"Sui Guard Protection", b"SGP", b"SGP - Security of digital assets on the sui network", b"https://images.hop.ag/ipfs/Qma2qNWYXJeWMqgFcVNAnXAPG6bzV151i12SLasZEwA3r1", 0x1::string::utf8(b"https://x.com/SGPonSui"), 0x1::string::utf8(b"https://suiguardprotection.com/"), 0x1::string::utf8(b"https://t.me/suiguardprotection"), arg1);
    }

    // decompiled from Move bytecode v6
}

