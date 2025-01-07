module 0xc7716ec2ba6c7e7a101490f481c303a9a49b4da515402cfc4571c19ee2584d05::fudi {
    struct FUDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUDI>(arg0, 9, b"FUDI", b"Foodie ", b"Foodie is meme coin created to show love to the lovers of food in the community ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c4355e13-4a86-47ad-a668-5dc3e457b598.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

