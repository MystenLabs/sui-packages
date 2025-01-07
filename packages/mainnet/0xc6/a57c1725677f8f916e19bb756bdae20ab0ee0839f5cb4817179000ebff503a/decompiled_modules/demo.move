module 0xc6a57c1725677f8f916e19bb756bdae20ab0ee0839f5cb4817179000ebff503a::demo {
    struct DEMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEMO>(arg0, 9, b"DEMO", b"DEMO", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/wK1Dh2t/D.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEMO>>(v1);
        0x2::coin::mint_and_transfer<DEMO>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEMO>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

