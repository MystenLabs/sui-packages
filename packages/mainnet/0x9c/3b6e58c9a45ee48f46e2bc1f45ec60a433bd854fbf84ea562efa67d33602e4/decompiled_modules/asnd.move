module 0x9c3b6e58c9a45ee48f46e2bc1f45ec60a433bd854fbf84ea562efa67d33602e4::asnd {
    struct ASND has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASND>(arg0, 5, b"ASND", b"ASCEND", b"The Future of DeFi Banking", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ASND>(&mut v2, 25000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASND>>(v2, @0x8a12cb041508d2079891f19dea3cfb1c56fc82a89ec9bcc9a0d95b5c5d488b92);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASND>>(v1);
    }

    // decompiled from Move bytecode v6
}

