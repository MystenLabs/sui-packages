module 0x841e0b496e663dc6cea469a9a4429d3b1a19df324b83b1548405874eb4588896::bunny {
    struct BUNNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUNNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUNNY>(arg0, 6, b"BUNNY", b"First Road Runner On Sui", b"Welcome to the journey of conquering new heights in the Meme ecosystem on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/logo_860c9fbac7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUNNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUNNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

