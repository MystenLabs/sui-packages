module 0x513b53f66197223cecb1ebb3d9489cbe7df5c297cdb639f41dae8171d30bcc7b::ratana {
    struct RATANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RATANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RATANA>(arg0, 6, b"RATANA", b"Sui Ratana", b"Welcome to Ratana  - a meme coin built on trust and community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012553_803a3703a0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RATANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RATANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

