module 0xbfc50d451559e1f2400e7a26fd571683fb89ba46d405564f389bf2b1ba117d6c::suifam {
    struct SUIFAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFAM>(arg0, 6, b"SUIFAM", b"SUITS FAM", b"WAGWAN FAM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUITS_53ac9686fb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

