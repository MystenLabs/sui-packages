module 0x59b311c3a5c9f06c2ff56320fcc61d1c74040bc45871206c5866cd611b1bc955::job {
    struct JOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOB>(arg0, 6, b"JOB", b"Believe In Job", b"The Vatican's boy mascot & lover of #Luce created by the Catholic Church, restoring faith & purpose in humanity. .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250112_033920_062_961cc2d18b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

