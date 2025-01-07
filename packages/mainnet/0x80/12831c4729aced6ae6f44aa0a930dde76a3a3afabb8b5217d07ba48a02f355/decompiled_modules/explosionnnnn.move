module 0x8012831c4729aced6ae6f44aa0a930dde76a3a3afabb8b5217d07ba48a02f355::explosionnnnn {
    struct EXPLOSIONNNNN has drop {
        dummy_field: bool,
    }

    fun init(arg0: EXPLOSIONNNNN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EXPLOSIONNNNN>(arg0, 6, b"EXPLOSIONNNNN", b"Megumin's Explosion", b"Inspired by Megumin's magic powers. A fiery Arch Wizard from the Crimson Demon Clan in KonoSuba, is known for her obsession with Explosion Magic", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000005582_9e3b90f910.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EXPLOSIONNNNN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EXPLOSIONNNNN>>(v1);
    }

    // decompiled from Move bytecode v6
}

