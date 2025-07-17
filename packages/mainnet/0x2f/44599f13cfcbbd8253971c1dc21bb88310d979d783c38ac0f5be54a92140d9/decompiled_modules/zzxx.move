module 0x2f44599f13cfcbbd8253971c1dc21bb88310d979d783c38ac0f5be54a92140d9::zzxx {
    struct ZZXX has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZZXX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZZXX>(arg0, 6, b"ZZXX", b"key", b"we are going to do some thing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibzzgvbe32hmpbjn26hymxyslufmv56urkmpotdryla3ohvalntrq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZZXX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZZXX>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

