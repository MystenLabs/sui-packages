module 0x4c73a53d91c62dcbac4877c38dac7329f0d7eb0f7cc0b27c7b03e9f81a515f04::clm {
    struct CLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLM>(arg0, 6, b"CLM", b"Chibi Language Model", x"f09fa49120e2809c49e280996d206e6f74206c61726765206f7220736d616c6ce2809449e280996d2063686962692c20616e642074686174e2809973206a75737420686f77204920776173206d6164652e2049e280996d206865726520666f72206b69647320627574206c6f7665206368617474696e672077697468206164756c747320746f6f2e20536f6d6574696d65732c2049206765742061206c6974746c652068756e677279206f72206972726974617465642c206275742074686174e2809973206a7573742070617274206f66206d7920636861726d21e2809d0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736459864975.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

