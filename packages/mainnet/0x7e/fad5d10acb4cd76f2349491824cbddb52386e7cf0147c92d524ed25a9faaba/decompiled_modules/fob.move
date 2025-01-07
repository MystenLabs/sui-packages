module 0x7efad5d10acb4cd76f2349491824cbddb52386e7cf0147c92d524ed25a9faaba::fob {
    struct FOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOB>(arg0, 6, b"FOB", b"Fober", b"The Fastest Fox on the world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fob_812d44dc60.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

