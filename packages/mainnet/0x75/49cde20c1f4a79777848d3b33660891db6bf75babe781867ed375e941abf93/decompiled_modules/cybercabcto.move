module 0x7549cde20c1f4a79777848d3b33660891db6bf75babe781867ed375e941abf93::cybercabcto {
    struct CYBERCABCTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYBERCABCTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CYBERCABCTO>(arg0, 6, b"CybercabCTO", b"Cybercab", b"Cybercab cto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004522_e9e9f15ffd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYBERCABCTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CYBERCABCTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

