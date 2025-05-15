module 0x2775b665fa5837592088e648e98e0597d79caedcc3039d4dc3a47dc647044134::ita {
    struct ITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ITA>(arg0, 6, b"ITA", b"ITA On Sui", x"49544120697320746865206c61737420746f206a6f696e20616e642074686520666972737420746f20726973652e0a0a412073696c656e742072656372756974206f662074686520416b617473756b6920666f7267656420696e2074686520736861646f7773206f66207468652053756920636861696e2e204954412063617272696573206e6f2070726f7068656379206e6f2070726f6d6973652e0a4f6e6c7920707572706f73652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicsgitxprzvo4ftceipjtvqt4lqsfpplkcmc3rxdbilcinq5ygnba")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ITA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ITA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

