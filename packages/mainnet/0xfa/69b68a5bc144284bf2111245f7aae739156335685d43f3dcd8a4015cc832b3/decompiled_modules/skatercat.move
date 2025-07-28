module 0xfa69b68a5bc144284bf2111245f7aae739156335685d43f3dcd8a4015cc832b3::skatercat {
    struct SKATERCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKATERCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKATERCAT>(arg0, 6, b"SkaterCat", b"SkaterPotatoCat", b"skatercat in moonbags", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicyv3fddp3s4hlh4e5ucdelevnnlig5v4q6cfbg5m7kyfr3usb2qe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKATERCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SKATERCAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

