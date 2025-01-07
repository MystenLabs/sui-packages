module 0x11ac3cfd209d6de3fb8df77f4235b60ac621a99694edb4b90c579a5157be2b66::otti {
    struct OTTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTTI>(arg0, 6, b"OTTI", b"OTTI ON SUI", b"The lightning-fast otter of the Sui waters! With sleek moves and boundless energy, $OTTI is here to bring the thrill of the chase to the Sui network. Dive in and ride the waves with this agile, unstoppable otter as it swims straight toward success!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OTTIER_cb1d87943d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTTI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OTTI>>(v1);
    }

    // decompiled from Move bytecode v6
}

