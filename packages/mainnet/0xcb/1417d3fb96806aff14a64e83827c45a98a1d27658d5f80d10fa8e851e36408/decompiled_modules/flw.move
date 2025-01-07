module 0xcb1417d3fb96806aff14a64e83827c45a98a1d27658d5f80d10fa8e851e36408::flw {
    struct FLW has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLW>(arg0, 6, b"Flw", b"Flow like water", b"So there was this slerf who was like kicking off, I dunno what he was doing but it was sick man he was like hands in the air like penis out", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmTh6SkBcnwhto2tj7vfVszSHve1wBWR2puTNmAjPPjN15?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FLW>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLW>>(v2, @0xf087f6f0bf5e8e84100c5ba86742f42f6bfa22909c41067c00fd4c83aa72beb3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLW>>(v1);
    }

    // decompiled from Move bytecode v6
}

