module 0x53681bb5dd53276de33259cfbb245ffffeba1902039778e09e86a1f0c695e071::suicide {
    struct SUICIDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICIDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICIDE>(arg0, 6, b"SUICIDE", b"Cats Vs Fwogs", b"Cats vs the gay fwogs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kungfu_ab07da1374.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICIDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICIDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

