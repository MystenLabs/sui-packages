module 0xf0c3b2e57cee832bf6c6ca82dcdd0a4ccd8fd2129b302616054c851b256cf9cc::psr {
    struct PSR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSR>(arg0, 6, b"PSR", b"POWERSTREETRANGERS", b"backstreets back and its morphin time", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmfTqNiPCd3cPZaHcXCTc4aQ3Tufm3Htj3HBogxLmgk9C8?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PSR>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSR>>(v2, @0xd3a665066ee7f19628771af3b4d81a7719a2a1502d20d3ff8cf3b176d20a3fb2);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PSR>>(v1);
    }

    // decompiled from Move bytecode v6
}

