module 0xddf9eb12eab3f3c7107977b389d604eda4b589ec5811c2266da0d8afabfbaee::gnv_token {
    struct GNV_TOKEN has drop {
        dummy_field: bool,
    }

    public fun decimals() : u8 {
        9
    }

    fun init(arg0: GNV_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GNV_TOKEN>(arg0, 9, b"GNV", b"Genome Value", b"HelixKey BioAuth Protocol. 1 GNV = computational power of the protocol. Supply = human genome nucleotide base pairs: 3,200,000,000.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://helixkey.bio/logo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<GNV_TOKEN>>(0x2::coin::mint<GNV_TOKEN>(&mut v2, 3200000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GNV_TOKEN>>(v2);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GNV_TOKEN>>(v1);
    }

    public fun total_supply() : u64 {
        3200000000000000000
    }

    // decompiled from Move bytecode v7
}

