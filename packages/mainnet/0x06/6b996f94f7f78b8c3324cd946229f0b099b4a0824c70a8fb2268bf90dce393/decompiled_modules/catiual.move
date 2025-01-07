module 0x66b996f94f7f78b8c3324cd946229f0b099b4a0824c70a8fb2268bf90dce393::catiual {
    struct CATIUAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATIUAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATIUAL>(arg0, 6, b"Catiual", b"Catiual ^^", b"Catiual ^^ on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d74ec577a3432c9c6676329d95777641_33e6db8dac.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATIUAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATIUAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

