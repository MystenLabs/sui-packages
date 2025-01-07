module 0xaa939ad49d9b714b1ab3c01a785ae75a10c640aa72119802bbcdca4a9cc2f233::uptober {
    struct UPTOBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: UPTOBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UPTOBER>(arg0, 6, b"UPTOBER", b"UP TOBER", b"UPTOBER FESTIVAL!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/We_Chat95dd5a291ea7838d8ba791f44bb35af9_35439eec25.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UPTOBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UPTOBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

