module 0xe768a35b575b3023dcb91e65c51f4a405efd47cf7289ac1a61a01c7b0e780d7d::scallop_af_sui {
    struct SCALLOP_AF_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALLOP_AF_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALLOP_AF_SUI>(arg0, 9, b"sAfSUI", b"sAfSUI", b"Scallop interest-bearing token for afSUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://letadg74k3lmsae3ro5diyntgfqyxm5coinwf3dkdzjb2itsvbiq.arweave.net/WSYBm_xW1skAm4u6NGGzMWGLs6JyG2Lsah5SHSJyqFE")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALLOP_AF_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALLOP_AF_SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

