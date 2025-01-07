module 0x769b16da217bef9a20f00911ddfccdaef9f4205ee4920b14178729b5f470ba98::munks {
    struct MUNKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUNKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUNKS>(arg0, 6, b"MUNKS", b"Munks", b"Your favourite monkey Munks is ready to take off at a speedy pace on her way to the Moon. This silly monkey with autism never got the affection she deserves.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_09_02_T212558_245_9853829e97.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUNKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUNKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

