module 0x672534c2f74ef1ae4778481f662ed83a0a2f49e77cf360a0ea1895da34824dec::tamasui {
    struct TAMASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAMASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAMASUI>(arg0, 6, b"TAMASUI", b"TAMAGOSUI", b"THE STORY OF TAMAGOSUI ON $SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihh3qlljz6g2hbb3rtv734sb6aua33jbqwidpibod3ln4wtkbdc7u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAMASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TAMASUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

