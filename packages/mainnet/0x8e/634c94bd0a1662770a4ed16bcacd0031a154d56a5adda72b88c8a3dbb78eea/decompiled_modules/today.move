module 0x8e634c94bd0a1662770a4ed16bcacd0031a154d56a5adda72b88c8a3dbb78eea::today {
    struct TODAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TODAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TODAY>(arg0, 6, b"TODAY", b"", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://api.movepump.com/uploads/PFP_e019216c48.jpg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TODAY>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TODAY>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TODAY>>(v2);
    }

    // decompiled from Move bytecode v6
}

