module 0x98291485917bc26824039e747b09f07831e2966d0aa88805b1f5280584eed065::suiphant {
    struct SUIPHANT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPHANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPHANT>(arg0, 6, b"Suiphant", b"Suiphant Emilio", x"486520697320456d696c696f20746865207665727920666972737420456c657068616e74206f6e205375692c0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_5e398308ee.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPHANT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPHANT>>(v1);
    }

    // decompiled from Move bytecode v6
}

