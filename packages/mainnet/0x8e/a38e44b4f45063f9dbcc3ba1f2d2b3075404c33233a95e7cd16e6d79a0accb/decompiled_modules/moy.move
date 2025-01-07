module 0x8ea38e44b4f45063f9dbcc3ba1f2d2b3075404c33233a95e7cd16e6d79a0accb::moy {
    struct MOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOY>(arg0, 6, b"MOY", b"Moypet", b"$MOY is your virtual pet, the cutest meme in the universe! Chat and play with $MOY for endless fun and joy!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000051857_63214a9052.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOY>>(v1);
    }

    // decompiled from Move bytecode v6
}

