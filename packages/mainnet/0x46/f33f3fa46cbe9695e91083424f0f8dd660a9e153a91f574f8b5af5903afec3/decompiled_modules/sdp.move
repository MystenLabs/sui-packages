module 0x46f33f3fa46cbe9695e91083424f0f8dd660a9e153a91f574f8b5af5903afec3::sdp {
    struct SDP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDP>(arg0, 6, b"SDP", b"Sui dolphin", b" the world's most famous dolphin, was a bottlenose dolphin. The other reason is they hold a special place in our hearts, since most the dolphins at Dolphins Plus are Atlantic bottlenose dolphins.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1530_56f6d1d650.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDP>>(v1);
    }

    // decompiled from Move bytecode v6
}

