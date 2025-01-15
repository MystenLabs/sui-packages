module 0x89eeb04522dd0b794704e6583a29f297795cd0c2ca6168405da81e560abf9e9::ou {
    struct OU has drop {
        dummy_field: bool,
    }

    fun init(arg0: OU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OU>(arg0, 9, b"Ou", b"Ou Ou", b"OUUUUUUUUUUUUUUUUUUUUU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYsdWTryyCHV4mkY973bn4xPxTmwASAdqXUrfGPR3x7TQ")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OU>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OU>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

