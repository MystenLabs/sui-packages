module 0xcefc1783f4260a58179713ec55a4714ebf74ff5cbf059cd1846a180802637d49::boobs {
    struct BOOBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOBS>(arg0, 6, b"BOOBS", b"BOOBS", b"Only BOOBS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/Qmd4HrFFnXwBdb7YsvfjxU5P3o47KSgSjJUWMnVWNF9hnz?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOOBS>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOBS>>(v2, @0x27eb87bc7371821110b327089a81a5af9ae33235fcd63784cb90a2d11bc25f5d);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

