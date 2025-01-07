module 0x21434588e08826c0b0f034029f3c1b989e09fa92abcb53f94f59cc8dabf565fc::cr3atures {
    struct CR3ATURES has drop {
        dummy_field: bool,
    }

    fun init(arg0: CR3ATURES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CR3ATURES>(arg0, 6, b"CR3ATURES", b"$CR3ATURES", b"Croco is the first croc on Sui. Join the Croco Cult & Chill.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_tiny_643412141d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CR3ATURES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CR3ATURES>>(v1);
    }

    // decompiled from Move bytecode v6
}

