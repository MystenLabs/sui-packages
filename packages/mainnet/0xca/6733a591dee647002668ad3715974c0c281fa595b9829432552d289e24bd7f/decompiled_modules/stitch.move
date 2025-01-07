module 0xca6733a591dee647002668ad3715974c0c281fa595b9829432552d289e24bd7f::stitch {
    struct STITCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: STITCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STITCH>(arg0, 6, b"STITCH", b"Stitch Coin", b"Stitch is a short, blue alien with a koala-like body shape. His large ears have asymmetrically placed triangular notches on the outer rims, one near the tip of his right ear and another near the base of his left ear, although these notches are occasionally misplaced in some media, usually on their respective opposite ears. The backs of the ear tips and the paw pads on his palms and soles are colored indigo.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmQAM2oLtkcbUs2rCN8qumSqNAakbqv3gi35phFs33Mqet?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STITCH>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STITCH>>(v2, @0xaca2a52083bd23b09cf8efe2c9b84903d04a46dba6c6f78b4ef06f8bbec1082);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STITCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

