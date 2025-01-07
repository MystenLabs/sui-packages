module 0x994c4a5d9495c150efc42f7b38b17607bb5e63fdf934ca91b58daf666e1d5fc3::ls {
    struct LS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LS>(arg0, 6, b"LS", b"AKa Lab Sui", b"AKA Ventures is a venture capital firm focusing exclusively on early-stage blockchain project decentralized finance, Fintech startup, NFT, Gamefi and Web3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/akalabs_0473133a10.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LS>>(v1);
    }

    // decompiled from Move bytecode v6
}

