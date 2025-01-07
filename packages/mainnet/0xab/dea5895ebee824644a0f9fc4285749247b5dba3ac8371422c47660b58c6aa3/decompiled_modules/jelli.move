module 0xabdea5895ebee824644a0f9fc4285749247b5dba3ac8371422c47660b58c6aa3::jelli {
    struct JELLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JELLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JELLI>(arg0, 6, b"Jelli", b"Jelli the drop", b"this is jelli from the bottom of the sui waters", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_43_bc88173be8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JELLI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JELLI>>(v1);
    }

    // decompiled from Move bytecode v6
}

