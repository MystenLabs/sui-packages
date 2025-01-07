module 0x288c0150b253720d08e59cd2e1288e4beb64d1ab9ee7af6c782891fad994a13::octav {
    struct OCTAV has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTAV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCTAV>(arg0, 6, b"OCTAV", b"Ococtav Sui", b"Octav is an octopus populating the sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000253_858c26599e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTAV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCTAV>>(v1);
    }

    // decompiled from Move bytecode v6
}

