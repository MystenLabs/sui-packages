module 0xff8835033110fb6a77a74ffb62fc829f5e0c89b0d4834cc91e6528a0dd6fe716::asuic {
    struct ASUIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASUIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASUIC>(arg0, 6, b"ASUIC", b"BobTheAsic", b"Bob Asic is an ambitious young miner who makes many calculations to leave the planet Sui and go to the Moon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731243681505.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASUIC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASUIC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

