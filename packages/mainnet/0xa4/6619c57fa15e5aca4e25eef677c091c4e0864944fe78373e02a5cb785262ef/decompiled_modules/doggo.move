module 0xa46619c57fa15e5aca4e25eef677c091c4e0864944fe78373e02a5cb785262ef::doggo {
    struct DOGGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGGO>(arg0, 6, b"DOGGO", b"SUIDOGGO", b"The first DOGGO of Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/166_d97aa1a5c8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

