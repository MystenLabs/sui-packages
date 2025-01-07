module 0xd111b3f1521826c47f539cb249314275bd2dc2d577714342f36bbbfe1bed4daf::lord {
    struct LORD has drop {
        dummy_field: bool,
    }

    fun init(arg0: LORD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LORD>(arg0, 6, b"LORD", b"DORKLORD", b"Prepare yourself, young Padawan, for the most epic memecoin in the $SUI galaxy: DORKLORD! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DOKRLOR_3ab91ca6a8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LORD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LORD>>(v1);
    }

    // decompiled from Move bytecode v6
}

