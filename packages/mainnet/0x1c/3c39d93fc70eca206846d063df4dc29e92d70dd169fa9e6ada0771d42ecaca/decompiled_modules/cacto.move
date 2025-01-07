module 0x1c3c39d93fc70eca206846d063df4dc29e92d70dd169fa9e6ada0771d42ecaca::cacto {
    struct CACTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CACTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CACTO>(arg0, 9, b"CACTO", b"Cacto", b"Cacto meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CACTO>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CACTO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CACTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

