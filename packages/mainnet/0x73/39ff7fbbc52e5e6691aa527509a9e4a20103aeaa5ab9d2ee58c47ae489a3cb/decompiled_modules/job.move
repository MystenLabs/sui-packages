module 0x7339ff7fbbc52e5e6691aa527509a9e4a20103aeaa5ab9d2ee58c47ae489a3cb::job {
    struct JOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOB>(arg0, 6, b"Job", b"JOB", b"BACK TO WORK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9760_28548beb9a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

