module 0x38f0cbc91c5effd3477d6a188660e54a222900eed0bf035731f5eec6a47c60bf::spooky {
    struct SPOOKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPOOKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPOOKY>(arg0, 6, b"Spooky", b"SPHOOKY", b"$SPHOOKY is a fun, Halloween-inspired token that adds a dash of ghostly charm to the blockchain! With its spooky mascot and playful vibe, Sphooky is designed for those who love the eerie season all year round. Whether you're into trick-or-treating your way through DeFi or just collecting ghoulish tokens, Sphooky is the ultimate choice for a hauntingly good time in crypto.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241101_204150_995_9a4e718e96.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPOOKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPOOKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

