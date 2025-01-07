module 0x91558515bf7093613795fbb0ea78df1fdf00c580b43bd772e10e84581fc909cb::keke {
    struct KEKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEKE>(arg0, 6, b"KEKE", b"KeKe", b"$PePe Alter Ego is Now here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6717_3b768a2ae1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KEKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

