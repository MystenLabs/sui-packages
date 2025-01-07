module 0x1dec25b823dd7adc8b4740692ac9e11a567a1704aa80343ccb7a83312a168d72::check {
    struct CHECK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHECK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHECK>(arg0, 6, b"Check", b"Check Mark on SUI", b"Verified as The First Blue Check on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bluecheck_on_sui_diff_background_6d985a08ed.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHECK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHECK>>(v1);
    }

    // decompiled from Move bytecode v6
}

