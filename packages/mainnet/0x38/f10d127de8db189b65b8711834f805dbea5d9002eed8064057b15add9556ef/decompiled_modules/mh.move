module 0x38f10d127de8db189b65b8711834f805dbea5d9002eed8064057b15add9556ef::mh {
    struct MH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MH>(arg0, 6, b"MH", b"MOONHOLE", b"JUST A MOONHOLE TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifrnro3byytx3a7ki52apefv6ep273fyahdokrbkxx3xm6hwnwxlm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

