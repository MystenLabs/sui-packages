module 0xbab4f6b7f0b1d716866ec2a76477130d16418fd87ceb774824e4c2c8a3a85083::emon {
    struct EMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMON>(arg0, 6, b"EMON", b"Sui Pokemon", b"EMON is that pokemon, always by your side, bringing luck, fun, and just the right amount of degen energy to every adventure on the blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibkcb24qwq7uziyi33qp76xoid4etnavnadcbpd66jjcdysf34pji")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EMON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

