module 0xf0abcdf7dd0803fbe036637f6a6302fbab3a1d86500ec4abd088e1772adfe7c6::hopper {
    struct HOPPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPPER>(arg0, 6, b"HOPPER", b"Hopper - Grok's FROG", x"486f707065722069732066697273742047726f6b27732066726f70206c696b6520706570652021200a200a2042756c6c697368206e616d6520616e642062756c6c697368206e61727261746976652021", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7819_e602fff40d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

