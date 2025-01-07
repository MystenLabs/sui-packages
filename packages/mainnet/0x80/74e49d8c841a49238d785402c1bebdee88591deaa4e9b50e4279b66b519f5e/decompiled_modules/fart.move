module 0x8074e49d8c841a49238d785402c1bebdee88591deaa4e9b50e4279b66b519f5e::fart {
    struct FART has drop {
        dummy_field: bool,
    }

    fun init(arg0: FART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FART>(arg0, 8, b"Fart", b"Fart", b"meme coin go to fart", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FART>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FART>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FART>>(v1);
    }

    // decompiled from Move bytecode v6
}

