module 0x306c66c7609d4a822f0c0bbd9b4eda8e775b0ede93398738dcf546fe0fd690a1::waaalady {
    struct WAAALADY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAAALADY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAAALADY>(arg0, 6, b"WAAALADY", b"Waaalady", b"waaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/washing_machine_9f7c474fb4.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAAALADY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAAALADY>>(v1);
    }

    // decompiled from Move bytecode v6
}

