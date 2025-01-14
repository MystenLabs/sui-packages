module 0xd3c5d6e8382dc5643efdf754db97950b81e5f925ef8965a56fc0cc6401aaac5c::ball {
    struct BALL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALL>(arg0, 9, b"BALL", b"Crypto Ball", b"Crypto Ball ($BALL)celebrating the inauguration of President Donald Trump, the first crypto-friendly leader, ushering in a new era of cryptocurrency. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmerGPaYX4tgkJba7FEkSGiur3ogHwwYcMMWszhpac2VHS")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BALL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BALL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALL>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

