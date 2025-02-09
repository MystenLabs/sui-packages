module 0x8faa16381296659f92690962a184279e75272a0bbd0a427695c1c0e1aa06bc91::plan {
    struct PLAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLAN>(arg0, 6, b"PLAN", b"PLANKTON", b"We are Plankton - Just for someone who believe that something big starts from something small. $PLAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000099267_0c0b0cd489.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

