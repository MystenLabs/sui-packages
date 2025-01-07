module 0xe352f4fde4f735c1bbfb16d6d334b69a887ced8bcb53dbd5790be67995342c6::poringscam {
    struct PORINGSCAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PORINGSCAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PORINGSCAM>(arg0, 6, b"PORINGSCAM", b"PORING SCAM", b"PORING meme token is scam project", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731019591224.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PORINGSCAM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PORINGSCAM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

