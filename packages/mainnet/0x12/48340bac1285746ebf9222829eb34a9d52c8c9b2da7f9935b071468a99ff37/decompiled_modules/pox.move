module 0x1248340bac1285746ebf9222829eb34a9d52c8c9b2da7f9935b071468a99ff37::pox {
    struct POX has drop {
        dummy_field: bool,
    }

    fun init(arg0: POX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POX>(arg0, 6, b"Pox", b"PoxOnSui", b" Monkey-level fun, monkey-level vibes! Join us on an epic journey to greatness ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Monkey_Pox_Sui_a7b1048191.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POX>>(v1);
    }

    // decompiled from Move bytecode v6
}

