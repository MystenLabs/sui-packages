module 0x5e4a1334f4cad0273f5b560832a0c247a72db449bb0d797676e4b79ee920362d::suilen {
    struct SUILEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILEN>(arg0, 6, b"SUILEN", b"Len Sessaman", b"SUILEN SYMBOL FOR LEN SESSAMAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://purple-neat-mole-319.mypinata.cloud/ipfs/QmV19uysquHKiGj8EH2vGSrjT5YYQDCYyykw1sArju2sTJ")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUILEN>(&mut v2, 21000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILEN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

