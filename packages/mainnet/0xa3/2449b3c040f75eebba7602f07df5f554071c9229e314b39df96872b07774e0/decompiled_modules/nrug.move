module 0xa32449b3c040f75eebba7602f07df5f554071c9229e314b39df96872b07774e0::nrug {
    struct NRUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NRUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NRUG>(arg0, 6, b"NRUG", b"DOOMPAPER", b"A crazy project and great fun... but we wont reveal all our secrets just yet! Dive into the project and join the good vibes, fun atmosphere, and a long-term vision thats built to last!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nnlogo_476534b71d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NRUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NRUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

