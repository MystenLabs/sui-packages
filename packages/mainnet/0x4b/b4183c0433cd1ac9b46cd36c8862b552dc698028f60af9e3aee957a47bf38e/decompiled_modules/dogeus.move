module 0x4bb4183c0433cd1ac9b46cd36c8862b552dc698028f60af9e3aee957a47bf38e::dogeus {
    struct DOGEUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGEUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGEUS>(arg0, 6, b"DOGEUS", b"DOGEUS MAXIMUS", b" DOGEUS is fighting to conquer the meme coin throne! Join the battle on and shape the future! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/avarta_d4fe390fab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGEUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGEUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

