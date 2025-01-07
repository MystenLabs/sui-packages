module 0x4c82bce10e55cfe0c41db4e6c7615fe5408b7546d0f58e5a142adfb7fe4f10e::blacksquare {
    struct BLACKSQUARE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLACKSQUARE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLACKSQUARE>(arg0, 6, b"blacksquare", b"blacksquare", b"A black square", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmaQvMZJ1wDX5YPfRE1xR25NWyeAWunGJ9XmR6cpYa1piZ?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLACKSQUARE>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLACKSQUARE>>(v2, @0x5e7be12191dab382c993aba5290fa7222c746485c24ae65984de4123d92797b1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLACKSQUARE>>(v1);
    }

    // decompiled from Move bytecode v6
}

