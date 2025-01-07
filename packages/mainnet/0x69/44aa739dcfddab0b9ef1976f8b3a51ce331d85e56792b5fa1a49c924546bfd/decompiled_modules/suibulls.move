module 0x6944aa739dcfddab0b9ef1976f8b3a51ce331d85e56792b5fa1a49c924546bfd::suibulls {
    struct SUIBULLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBULLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBULLS>(arg0, 6, b"Suibulls", b"Sui bulls", x"5375692042756c6c73206973206120636f6d6d756e6974792d64726976656e206d656d6520636f696e206f6e207468652053756920626c6f636b636861696e2c206368617267696e67207468726f756768207468652063727970746f206c616e64736361706520776974682074686520737069726974206f66207468652062756c6c2120546869732070726f6a6563742069736ee2809974206a757374206120636f696e3b206974e28099732061206d6f76656d656e7420746f2063656c6562726174652074686520626f6c642c20756e73746f707061626c6520656e65726779206f66206d656d652063756c74757265", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731022879062.42")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIBULLS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBULLS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

