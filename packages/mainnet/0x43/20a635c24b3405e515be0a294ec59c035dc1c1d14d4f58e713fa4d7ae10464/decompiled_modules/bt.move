module 0x4320a635c24b3405e515be0a294ec59c035dc1c1d14d4f58e713fa4d7ae10464::bt {
    struct BT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BT>(arg0, 9, b"BT", b"BULL TOKEN", b"BULL TOKEN is a community driven meme token built on the sui block chain. This meme token is aiming to become the biggest meme token on the SUI BLOCK CHAIN. This has a total supply of 1 billion tokens. Just for the community and it's growth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a0cc2aad-45c7-4bed-a883-053ff707f622.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BT>>(v1);
    }

    // decompiled from Move bytecode v6
}

