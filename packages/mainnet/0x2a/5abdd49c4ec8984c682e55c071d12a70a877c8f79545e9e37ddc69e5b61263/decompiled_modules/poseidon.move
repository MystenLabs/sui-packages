module 0x2a5abdd49c4ec8984c682e55c071d12a70a877c8f79545e9e37ddc69e5b61263::poseidon {
    struct POSEIDON has drop {
        dummy_field: bool,
    }

    fun init(arg0: POSEIDON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POSEIDON>(arg0, 6, b"Poseidon", b"Poseidon Token", b"Welcome to the next generation of meme coin, a god in ancient greek mythology", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/488466385_649936917653217_8129236090576857745_n_e8404ec7e5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POSEIDON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POSEIDON>>(v1);
    }

    // decompiled from Move bytecode v6
}

