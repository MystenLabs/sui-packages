module 0x23616c524efb4c3464c88857137bca61e59fc2377525832c392f87975b11e807::fui {
    struct FUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUI>(arg0, 6, b"FUI", b"FUI on SUI", b"FUI is the first Arctic Fox crawling to the top of the SUI network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/34390d36_f6cb_48a8_964b_615881a277ee_a0bd9fbfd5.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

