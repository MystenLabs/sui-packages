module 0x2fb1ff606cac64348524dea1830fe372b708fdcf9e63b60ed5b4e74338e703e9::ta {
    struct TA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TA>(arg0, 9, b"TA", b"tabasum", b"a dun coin based on a person nick name", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7c6e0a74-c696-4d39-96bb-9bf1ea04e749.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TA>>(v1);
    }

    // decompiled from Move bytecode v6
}

