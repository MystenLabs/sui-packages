module 0xc855bebedddd04204091ea0478ef98718c09537f5fd6f167012f42b47a4bec2b::SUISQUID {
    struct SUISQUID has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<SUISQUID>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUISQUID>>(arg0, arg1);
    }

    fun init(arg0: SUISQUID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISQUID>(arg0, 9, b"SUISQUID", b"SSQUID", b"Join with us web : https://SUISQUID.xyz , tg : @SUISQUIDportal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmRo3EAbeNajei7Q1tsY778W4BBfy2SvrcFCmJPKVZUfhN?_gl=1*1coko6v*rs_ga*NGMxYTE0YzUtNjg3OS00MTMxLThhM2EtMGZiMjljNzQ2OWYz*rs_ga_5RMPXG14TE*MTY4MzI4ODI5My4xLjEuMTY4MzI4ODQ5Mi40OC4wLjA")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<SUISQUID>(&mut v2, 1000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISQUID>>(v2, v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISQUID>>(v1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUISQUID>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUISQUID>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

