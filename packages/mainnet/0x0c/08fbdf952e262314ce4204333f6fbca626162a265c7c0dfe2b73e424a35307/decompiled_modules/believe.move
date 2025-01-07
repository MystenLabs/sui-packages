module 0xc08fbdf952e262314ce4204333f6fbca626162a265c7c0dfe2b73e424a35307::believe {
    struct BELIEVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BELIEVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BELIEVE>(arg0, 6, b"Believe", b"Believe in", b"Believe in SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Believe_00e0191983.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BELIEVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BELIEVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

