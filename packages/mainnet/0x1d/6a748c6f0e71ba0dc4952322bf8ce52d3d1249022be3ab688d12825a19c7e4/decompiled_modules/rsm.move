module 0x1d6a748c6f0e71ba0dc4952322bf8ce52d3d1249022be3ab688d12825a19c7e4::rsm {
    struct RSM has drop {
        dummy_field: bool,
    }

    fun init(arg0: RSM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RSM>(arg0, 6, b"RSM", b"RuneScapeMemes", b"The time has come, my king. Must call upon all brothers and sisters. Your calling awaits.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/xg_FHC_4cm_400x400_9235fe621f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RSM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RSM>>(v1);
    }

    // decompiled from Move bytecode v6
}

