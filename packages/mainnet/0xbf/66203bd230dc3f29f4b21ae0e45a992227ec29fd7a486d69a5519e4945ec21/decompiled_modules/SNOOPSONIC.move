module 0xbf66203bd230dc3f29f4b21ae0e45a992227ec29fd7a486d69a5519e4945ec21::SNOOPSONIC {
    struct SNOOPSONIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOOPSONIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOOPSONIC>(arg0, 6, b"SNOOPSONIC", b"SNOOPSONIC", b"Find Our Community On Discord", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/ClNfMPT.jpeg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SNOOPSONIC>(&mut v2, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOOPSONIC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNOOPSONIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

