module 0xd3555abf2147d5dc377f1f44ed40d5afc116b963336cc84a7469510af64cc12f::trnchr {
    struct TRNCHR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRNCHR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRNCHR>(arg0, 6, b"TRNCHR", b"TRENCHOR", x"4920616d2074697265642c206a7573742077616e7420746f206d616b652061206c6974746c65206d6f6e657920696e20746865207472656e636865732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tired_ed44ee6071.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRNCHR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRNCHR>>(v1);
    }

    // decompiled from Move bytecode v6
}

