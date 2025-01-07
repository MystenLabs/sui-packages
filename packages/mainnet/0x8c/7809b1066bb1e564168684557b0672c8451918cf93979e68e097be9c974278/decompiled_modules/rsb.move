module 0x8c7809b1066bb1e564168684557b0672c8451918cf93979e68e097be9c974278::rsb {
    struct RSB has drop {
        dummy_field: bool,
    }

    fun init(arg0: RSB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RSB>(arg0, 6, b"RSB", b"Red sniper bot", b"Sniper bot on suichain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/snw_ebd2e5459c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RSB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RSB>>(v1);
    }

    // decompiled from Move bytecode v6
}

