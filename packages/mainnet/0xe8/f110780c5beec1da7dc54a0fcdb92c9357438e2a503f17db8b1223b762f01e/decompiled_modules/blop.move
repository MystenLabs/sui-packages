module 0xe8f110780c5beec1da7dc54a0fcdb92c9357438e2a503f17db8b1223b762f01e::blop {
    struct BLOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOP>(arg0, 6, b"BLOP", b"Blop", b"Built as the cousin of BLAP, BLOP arrives with a stronger ecosystem and a focus on real utility within the Sui blockchain network. With a limited supply and deflationary mechanisms", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250112_223957_c6700be398.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

