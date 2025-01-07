module 0x558067db0907b2f7b083b80918d141162db6492ef24247ba8936144e31382a57::pengsui {
    struct PENGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGSUI>(arg0, 6, b"PengSui", b"Penguin on Sui", x"70656e67207375692070656e67207375692070656e67207375692070656e67207375690a7375692070656e67207375692070656e67207375692070656e67207375692070656e67", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4ed795f7_f38b_41ee_8eec_2b6355a892c8_57427fb3a8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

