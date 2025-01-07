module 0x4a8709e1d8a407a151aa7f1bf8a9b5d659545b3f9d63ff0ad86b4ed49b68ba95::vi {
    struct VI has drop {
        dummy_field: bool,
    }

    fun init(arg0: VI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VI>(arg0, 6, b"VI", b"VIRGIN", b"ai generated virgin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/VIRGIN_d1f28caeeb.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VI>>(v1);
    }

    // decompiled from Move bytecode v6
}

