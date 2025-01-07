module 0x83a13a7b924dbe19744e795d73c9b9c8f34328813db0669285314e1beae56104::ews {
    struct EWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: EWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EWS>(arg0, 6, b"EWS", b"Emperor Wen of SUI", x"456d7065726f722057656e206f662053554920666f756e64696e6720656d7065726f72206f66205355492044796e617374790a0a57652077696c6c20636f6e717565722065766572796f6e65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000005545_3df98f0a69.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

