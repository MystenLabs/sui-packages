module 0x1517da9395149610f0caaf7dcd3ea2e48a772d217f81bb95ec1d59bef5568d45::tmh {
    struct TMH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TMH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TMH>(arg0, 9, b"TMH", b"Three mush", b"Three mushrooms", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d732003f-22a6-4768-8cc5-babac9e76768.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TMH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TMH>>(v1);
    }

    // decompiled from Move bytecode v6
}

