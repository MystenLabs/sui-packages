module 0xaf97fa2f80f4268bf50ef12b312dfe90025dfefe4cf1338453f052fa1a946766::rabbit {
    struct RABBIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RABBIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RABBIT>(arg0, 6, b"RABBIT", b"BOOK OF RABBIT", x"4920414d20544845204755494445204f4620524142424954532e20414c4c204f46205448454d204c495354454e20544f204d5920574f52445320414e44205452555354204d4520f09fa493", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmT3WA5tdhVk3NvcWgxFEEiU1tk81137tfdA9D573uXqCe?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RABBIT>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RABBIT>>(v2, @0xb8c5caa5dbbefb02cae8d219a1ee1fae5eba58ec0deedd84a9272e4ac789f03);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RABBIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

