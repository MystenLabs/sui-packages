module 0x273081de3d713b9b5e38043705f68963603be177f71c8829d1cf8562a7db5ff1::zeni {
    struct ZENI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZENI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZENI>(arg0, 6, b"ZENI", b"ZENI-DEFI", b"Zeni-Defi is a groundbreaking cryptocurrency token built on the Sui Blockchain, poised to revolutionize the decentralized finance (DeFi) landscape. Leveraging Sui's cutting-edge technology, Zeni-Defi empowers users with unparalleled financial freedom, security and scalability.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0126e4cc_032f_488e_ae9d_b64b365a9a16_9c5d594469.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZENI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZENI>>(v1);
    }

    // decompiled from Move bytecode v6
}

