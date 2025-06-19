module 0xb625f2ac0d057d9773dfc48abfcfafc98e4d7c998f217cb03961553ee0624d76::srm {
    struct SRM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRM>(arg0, 6, b"SRM", b"SUIREWARDS.ME", b"WORLD'S FIRST REWARDS DEX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifpecvodiuuimrwvmxbn5dhtrnk4q3yjyarr3ztirolhmivbkikei")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SRM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

