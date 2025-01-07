module 0x68e31d81dc1ca63275d7e9fe0a7166d53365dd841191ead696204589a2a3a4ff::droppy {
    struct DROPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DROPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DROPPY>(arg0, 6, b"Droppy", b"DroppyOnSui", b"Play the Droppy on Sui TG game to win in the Sui ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/t0_OC_Trba_400x400_3da3079ab5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DROPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DROPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

