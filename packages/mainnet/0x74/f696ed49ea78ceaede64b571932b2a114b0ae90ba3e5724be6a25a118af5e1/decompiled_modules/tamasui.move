module 0x74f696ed49ea78ceaede64b571932b2a114b0ae90ba3e5724be6a25a118af5e1::tamasui {
    struct TAMASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAMASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAMASUI>(arg0, 6, b"TAMASUI", b"TAMAGOSUI", b"The Story of TAMAGOSUI On SUI !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihh3qlljz6g2hbb3rtv734sb6aua33jbqwidpibod3ln4wtkbdc7u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAMASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TAMASUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

