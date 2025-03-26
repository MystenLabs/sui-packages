module 0xeec969b77dd49c2dbc5705c075417e7aa3a74438b0485526882d6791970e79e2::jmind {
    struct JMIND has drop {
        dummy_field: bool,
    }

    fun init(arg0: JMIND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JMIND>(arg0, 6, b"JMIND", b"Jesse Mind", b"JesseMind ($JMIND) is where meme magic meets mega-minds on SUI . Big brains equal big gainsunleash your inner genius and dive into a revolution of wit, innovation, and pure crypto chaos!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9053_685be7eb93.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JMIND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JMIND>>(v1);
    }

    // decompiled from Move bytecode v6
}

