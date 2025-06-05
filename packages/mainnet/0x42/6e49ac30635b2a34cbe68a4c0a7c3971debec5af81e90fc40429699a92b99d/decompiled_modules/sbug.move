module 0x426e49ac30635b2a34cbe68a4c0a7c3971debec5af81e90fc40429699a92b99d::sbug {
    struct SBUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBUG>(arg0, 6, b"SBUG", b"SUI BUG", b"The cutest ladybug on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiav3b2xeind4eesp2ma3m4nvkzt5vo7sad66fof4z3w3zvfnui2gm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SBUG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

