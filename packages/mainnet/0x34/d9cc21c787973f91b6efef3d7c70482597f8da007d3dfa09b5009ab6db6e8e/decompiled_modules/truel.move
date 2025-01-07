module 0x34d9cc21c787973f91b6efef3d7c70482597f8da007d3dfa09b5009ab6db6e8e::truel {
    struct TRUEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUEL>(arg0, 6, b"TRUEL", b"TrumpElon", b"Crypto Antusiast Fans Meme On SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241010_015448_381d876d99.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

