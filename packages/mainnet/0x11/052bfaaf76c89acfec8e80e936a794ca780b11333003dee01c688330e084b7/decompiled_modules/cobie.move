module 0x11052bfaaf76c89acfec8e80e936a794ca780b11333003dee01c688330e084b7::cobie {
    struct COBIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COBIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COBIE>(arg0, 6, b"COBIE", b"Cobie On Sui", b"Kurt Cobain is a famous singer in the 90's, even though his soul has died, his spirit still burns and inspires many people", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000006609_e11e85a702.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COBIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COBIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

