module 0x587172fbe8f625ad0f90ba4d3685ad711aeb63a65a123ea73d35f279fdbaaf58::larry {
    struct LARRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LARRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LARRY>(arg0, 6, b"LARRY", b"Larry The Bird", b"Once upon a time the twitter logo was a bird. That bird had a name. $LARRY.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/portal_c8f2338b92.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LARRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LARRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

