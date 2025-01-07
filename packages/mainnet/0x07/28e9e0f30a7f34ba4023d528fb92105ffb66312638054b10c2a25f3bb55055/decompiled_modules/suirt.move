module 0x728e9e0f30a7f34ba4023d528fb92105ffb66312638054b10c2a25f3bb55055::suirt {
    struct SUIRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRT>(arg0, 6, b"Suirt", b"Suirtle", b"Suirtle is landing on Sui to become the number one mascot!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/avatar_32bec1f1d6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRT>>(v1);
    }

    // decompiled from Move bytecode v6
}

