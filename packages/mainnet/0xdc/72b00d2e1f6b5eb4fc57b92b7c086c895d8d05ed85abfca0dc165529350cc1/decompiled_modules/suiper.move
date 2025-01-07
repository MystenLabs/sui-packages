module 0xdc72b00d2e1f6b5eb4fc57b92b7c086c895d8d05ed85abfca0dc165529350cc1::suiper {
    struct SUIPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPER>(arg0, 6, b"Suiper", b"Suiperman", b"Suiperman is an innovative token that presents itself as a modern solution to protect and enhance your investments. In an often volatile and uncertain financial market, Suiperman stands out for its approach focused on security and transparency. With advanced blockchain technology, this token offers secure and fast transactions, as well as a rewards system that encourages investor loyalty. Through strategic partnerships and an engaged community, Suiperman aims to not only preserve the value of investors' assets but also deliver sustainable growth. By integrating cutting-edge features and a dedicated support team, Suiperman positions itself as a reliable choice for those seeking stability and innovation in the cryptocurrency market.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gccf_Nd_LWYAA_9xb1_7d238a8a12.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

