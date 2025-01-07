module 0x6372a866f65ebc526f4f02f990c6cd04d45e4e3f5f8ed9690b01e4f85bfc73f0::paw {
    struct PAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAW>(arg0, 9, b"PAW", b"Pawthereum", b"A next-gen meme token blending fun and purpose. PAW fuels a vibrant community, supports animal welfare, and offers staking rewards. Buy PAW to make a difference!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/17ce2a15-d51b-4981-9950-758a28a0f334.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAW>>(v1);
    }

    // decompiled from Move bytecode v6
}

