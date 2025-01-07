module 0xf9df279c4830d24ce9a2ec98f4bb3789c074e51b180700f57f569cec510e847b::swcat {
    struct SWCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWCAT>(arg0, 6, b"SWCat", b"Wizard Cat", b"In the Magically growing Meme space, one tokens was born with a purpose to magically rule them all.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_0252fc061c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

