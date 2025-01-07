module 0x51c39d1e71d849952259e0268abad62c619141ab217260619fe3612c05ebb26b::udd {
    struct UDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: UDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UDD>(arg0, 6, b"UDD", b"Udd of Sui", b"Meet $UDD, the one and only original character thats breaking the mold. Unlike those copycat characters, UDD is 100% unique and built to stand out on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/UDD_1_2_82c850fc53.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UDD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UDD>>(v1);
    }

    // decompiled from Move bytecode v6
}

