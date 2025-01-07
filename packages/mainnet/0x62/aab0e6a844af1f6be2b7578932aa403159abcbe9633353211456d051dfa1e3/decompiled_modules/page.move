module 0x62aab0e6a844af1f6be2b7578932aa403159abcbe9633353211456d051dfa1e3::page {
    struct PAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAGE>(arg0, 6, b"PAGE", b"Hager", b"Hi, Im Hager the pager! Im ready to explode to the moon! Beep, Beep, Beep, Beep", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pager_fc817d05e9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

