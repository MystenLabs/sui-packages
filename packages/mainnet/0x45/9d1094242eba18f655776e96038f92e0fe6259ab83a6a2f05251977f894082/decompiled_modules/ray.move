module 0x459d1094242eba18f655776e96038f92e0fe6259ab83a6a2f05251977f894082::ray {
    struct RAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAY>(arg0, 6, b"RAY", b"Ray on Sui", x"574520415245204c495645212121200a0a54686520626573742052415920696e205375692121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/reay_d41156c7cd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

