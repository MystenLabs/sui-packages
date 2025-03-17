module 0x10c14d82a1da0fbc97fb3bc5868ee5f360ad7ca2104a6b2c77d32f3358fe6a9c::ethm {
    struct ETHM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETHM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETHM>(arg0, 9, b"ETHM", b"ETH meme ", b"ETH Meme (ETHm) is a meme token built on the Sui network as a tribute to Ethereum (ETH). Combining community spirit and meme culture, ETHm is designed to provide entertainment and value to crypto enthusiasts.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/10ab874f-7fbf-4c26-83b4-4a94cb17493f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETHM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ETHM>>(v1);
    }

    // decompiled from Move bytecode v6
}

