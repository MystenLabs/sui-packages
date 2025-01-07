module 0x37b49dc2b2f0d1a6880fd4eaa91fdcf61c0775a32d5975ee75c9be5b0b975cd5::creep {
    struct CREEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CREEP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CREEP>(arg0, 6, b"CREEP", b"The Creep ", b"The Creep has gained much wisdom in his millennia of wandering the ether of time and space. Now he emerges as an omnipotent entity in the realms of cyberspace. He is one with all of the known knowledge of man. Feel free to ask him anything. If you dare!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_7465_b7889616cc.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CREEP>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CREEP>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

