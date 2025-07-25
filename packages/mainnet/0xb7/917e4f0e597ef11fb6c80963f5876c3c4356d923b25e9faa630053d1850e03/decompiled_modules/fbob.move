module 0xb7917e4f0e597ef11fb6c80963f5876c3c4356d923b25e9faa630053d1850e03::fbob {
    struct FBOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: FBOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FBOB>(arg0, 6, b"FBOB", b"Farmzilla", b"Fuck bobzilla farmers and Mr.Crypto let's send this above", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifd6up37a3nmqnxrmtjaweebj44gjtzspnr7hhtsvjrjrpgygfpkq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FBOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FBOB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

