module 0xb84f93ff5a908186f1e3e37182bfa9523df7a019576ba767588bb062b14f5b80::titan {
    struct TITAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TITAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TITAN>(arg0, 6, b"TITAN", b"THE TITANS", b"Armored in strength, united in vision. Defenders of innovation and builders of a new meme meta", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tit_e62d36b0d7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TITAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TITAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

