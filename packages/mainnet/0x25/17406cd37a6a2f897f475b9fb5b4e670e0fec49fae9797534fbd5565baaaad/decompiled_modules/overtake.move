module 0x2517406cd37a6a2f897f475b9fb5b4e670e0fec49fae9797534fbd5565baaaad::overtake {
    struct OVERTAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: OVERTAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OVERTAKE>(arg0, 9, b"OVERTAKE", b"Overtake", b"Overtake token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/bafkreiasqyv633f6tejadxmtbohngrocldci33qzfgqqbk5hdmikk4rdlq")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OVERTAKE>(&mut v2, 1000000000000000000, @0xad5107e84bc05b15d340f6738f788c09205c75e4b9d5b12707c8ef6a3b8e7def, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OVERTAKE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OVERTAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

