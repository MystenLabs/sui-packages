module 0xbb6a89427dcf895f71839ac89f5e3abd18fd7d973af62d57dcb96299b64d4fbe::kyosui {
    struct KYOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KYOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KYOSUI>(arg0, 6, b"KYOSUI", b"KYOGRE on SUI", b"This's a legendary pokemon of Sui Blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeia6ewh3qdbb52oejbf4vxgxxwwsccrurpjkybpggi365jzalprjxy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KYOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KYOSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

