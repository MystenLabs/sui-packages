module 0x80cd261682e1e968680c806aafc12cce7fc491cbc0ae4cc80d65c4b4c32caa59::delor {
    struct DELOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: DELOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DELOR>(arg0, 6, b"Delor", b"DeLoreanlabs", b"As part of the DeLorean Motor Company (DMC) ecosystem, DeLorean Labs is hyper-focused on innovative Web3 technologies and all things digital, a fusion between an iconic past and limitless future. DeLorean Labs aims to revolutionize the automotive industry by building an engaged community through its tokenized ecosystem, including digital and physical collectibles, and creating a marketplace and protocols powered by the Sui Blockchain. All designed not just for DeLorean but widespread adoption throughout the sector.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/media_2_963ac51fd7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DELOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DELOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

