module 0x6d7f08dee95b9c27b3f7b526b78b8ecfe89e4887ece827ec20a3031f770fab5d::job {
    struct JOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOB>(arg0, 6, b"Job", b"Im really tired", b"This token only for people who work 10hrs a day", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5843_f427c54af0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

