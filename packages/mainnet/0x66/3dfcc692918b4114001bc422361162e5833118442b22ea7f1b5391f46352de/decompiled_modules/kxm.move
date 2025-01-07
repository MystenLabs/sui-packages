module 0x663dfcc692918b4114001bc422361162e5833118442b22ea7f1b5391f46352de::kxm {
    struct KXM has drop {
        dummy_field: bool,
    }

    fun init(arg0: KXM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KXM>(arg0, 6, b"KXM", b"kamalaxtrump", b"kamala vs trump is now token 1000x in move pump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OIP_1_eea985e858.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KXM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KXM>>(v1);
    }

    // decompiled from Move bytecode v6
}

