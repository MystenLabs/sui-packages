module 0x118fc97bc30c79af1adfa62bb83b308c88c3390d0110143b163894a2ab3f582e::sac {
    struct SAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAC>(arg0, 6, b"SAC", b"Stoners Are Chads", x"50454f504c452057484f2046414445442041524520434f50494e470a54484520245341432043554c5420495320464f524d494e470a4348414453204c4f434b494e472055502054484520535550504c590a594f55204b4e4f5720574841542054494d452049542049533f0a343034732041524520544845204655545552452e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000024467_3d73389dc9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

