module 0xf54095ede283b26b7336df488b8d223f610a150f7f3d23ddf4f97f3f237f2e2f::iachu {
    struct IACHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: IACHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IACHU>(arg0, 9, b"IACHU", b"IACHU", b"$IACHU - is the key for the AI future | Language model | AI Trader |", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/M1D1kZJ/Leonardo-Phoenix-10-Generate-an-image-of-a-hybrid-creature-com-1-modified.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<IACHU>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IACHU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IACHU>>(v1);
    }

    // decompiled from Move bytecode v6
}

