module 0xb0ca4f284a27736d57bbbaf07b62caa9efdb2a7a164890c5bd26997d416d98f0::ew {
    struct EW has drop {
        dummy_field: bool,
    }

    fun init(arg0: EW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EW>(arg0, 6, b"EW", b"meme coin hunter", b"hunting the meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmNvaQaD5XY4BPSuG7HtpSeKsaDeqw2tUwRbNS3ZSrbBQp?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EW>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EW>>(v2, @0xf9ff8026df0b36b7b440dcc7e4b28700df6729d7ab60c5d7477d7db09de1b20d);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EW>>(v1);
    }

    // decompiled from Move bytecode v6
}

