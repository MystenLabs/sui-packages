module 0xa3a761c113b03aeca0f7016a718b606757fde98d8c3a89a49530df5f0703e43::echo {
    struct ECHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ECHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ECHO>(arg0, 6, b"ECHO", b"ECHO the SEAL", b"https://x.com/ech0agent", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_500_x_500_px_a017b68419_661e7635a4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ECHO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ECHO>>(v1);
    }

    // decompiled from Move bytecode v6
}

