module 0xb7d390974d5992c81e35337fcca24f51b848a7b28ef33b7349b6ad96bb440cb9::suiwig {
    struct SUIWIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWIG>(arg0, 6, b"SUIWIG", b"Suiwig Ponzi", b"$SUIWIG MAKE PONZI GREAT AGAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreid44uvtf4cp344k4agwhcfdezvhoilimhvb6awub4gmbbnpmodnu4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIWIG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

