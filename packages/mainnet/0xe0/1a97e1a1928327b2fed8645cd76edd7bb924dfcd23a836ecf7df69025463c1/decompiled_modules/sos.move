module 0xe01a97e1a1928327b2fed8645cd76edd7bb924dfcd23a836ecf7df69025463c1::sos {
    struct SOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOS>(arg0, 6, b"SOS", b"Solana on Sui", x"4a75737420534f53200a736f667420636170202d20333030207375690a6861726420636170202d2032303030207375690a0a4e6f2074776974746572206e6f20646973636f7264206f6e6c79207468697320776562207369746520616e642075722068616e64", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmZhKcFZVvw5r3cGLfSLsLcd1GzbQK5Vf7aoVYvgktzUUA?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SOS>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOS>>(v2, @0x44d6dc4e1abbdfee685fc40c45442cec378c86c3611a18fc674deba436a17e60);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

