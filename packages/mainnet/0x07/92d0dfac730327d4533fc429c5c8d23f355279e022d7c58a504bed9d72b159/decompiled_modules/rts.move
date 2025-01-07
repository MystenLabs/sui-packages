module 0x792d0dfac730327d4533fc429c5c8d23f355279e022d7c58a504bed9d72b159::rts {
    struct RTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RTS>(arg0, 6, b"RTS", b"Trump Sui", b"Welcome America!!!! We bring you a Trump branded coin!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9ddma_CYO_400x400_dfe177f7db.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

