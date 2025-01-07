module 0xb77514fd30435fe298bfd0aeee30e0297301248ebd81c215a4388bfbb27eee4c::gronch {
    struct GRONCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRONCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRONCH>(arg0, 6, b"GRONCH", b"Gronch", b"Join the meanest, greenest community in crypto. Or dontits not like I care. But when you see $GRONCH pumping, you`ll wish you had. Smelly, merry Christmas!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/35345_5bf995139c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRONCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRONCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

