module 0x910ffa9f466700e3b3aab84eacd64c3aeda7277d63979f05df44014abc581fdb::fgh {
    struct FGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FGH>(arg0, 9, b"FGH", b"FG", b"FGHG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/23662d3b-3531-4b2a-b742-2baf86854e76.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FGH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FGH>>(v1);
    }

    // decompiled from Move bytecode v6
}

