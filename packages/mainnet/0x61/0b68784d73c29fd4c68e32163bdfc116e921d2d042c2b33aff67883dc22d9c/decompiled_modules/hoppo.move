module 0x610b68784d73c29fd4c68e32163bdfc116e921d2d042c2b33aff67883dc22d9c::hoppo {
    struct HOPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPPO>(arg0, 6, b"Hoppo", b"Hip Hoppo", x"4869702024486f70706f206f6e206d6f766570756d70207c20506172746e657273686970200a407375697069656e730a207c20417274206279204645464521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sdfsfsdfsf_701d694104.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

