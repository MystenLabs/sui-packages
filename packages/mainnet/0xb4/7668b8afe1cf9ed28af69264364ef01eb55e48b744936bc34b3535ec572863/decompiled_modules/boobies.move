module 0xb47668b8afe1cf9ed28af69264364ef01eb55e48b744936bc34b3535ec572863::boobies {
    struct BOOBIES has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOBIES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOBIES>(arg0, 6, b"Boobies", b"PokeBoobies", b"100% community token without Realsuiguy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiarlxx6yxca3znedhl3g5ggbjuyqcpvqzbpfugkuyocq2atcivrsy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOBIES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOOBIES>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

