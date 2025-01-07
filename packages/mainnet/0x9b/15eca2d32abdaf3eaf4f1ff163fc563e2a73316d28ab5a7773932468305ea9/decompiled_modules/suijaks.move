module 0x9b15eca2d32abdaf3eaf4f1ff163fc563e2a73316d28ab5a7773932468305ea9::suijaks {
    struct SUIJAKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIJAKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIJAKS>(arg0, 6, b"SUIJAKS", b"Sui Jak's", b"Wow hes literally me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_Jak_s_ec6dc068aa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIJAKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIJAKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

