module 0x4444511536f44a211b5bd2f8f32874d4b07764e53d21c87778161d0eb5c0ab34::sc {
    struct SC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SC>(arg0, 6, b"SC", b"Shark Cat", b"Just a shark cat ting", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sharkcatprof_4390e6ddab.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SC>>(v1);
    }

    // decompiled from Move bytecode v6
}

