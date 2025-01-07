module 0x74a10b27bbc5cef3f6d8e19ed4a94c0f36b8d68a068939d47aabf83fdbbb3aa2::saylor {
    struct SAYLOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAYLOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAYLOR>(arg0, 9, b"SAYLOR", b"Michael Saylor", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/ryLyu3B.png"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SAYLOR>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAYLOR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAYLOR>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

