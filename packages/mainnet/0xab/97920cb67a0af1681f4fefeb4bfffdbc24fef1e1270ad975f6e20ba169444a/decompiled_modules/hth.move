module 0xab97920cb67a0af1681f4fefeb4bfffdbc24fef1e1270ad975f6e20ba169444a::hth {
    struct HTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HTH>(arg0, 9, b"HTH", b"HEALTH", b"Health is a revolutionary digital currency aimed at transforming the healthcare landscape. By incentivizing healthy choices and wellness activities, users can earn rewards that support medical expenses and wellness programs.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d8de5956-1bbd-4f71-a6ec-22d3f1ddec50.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HTH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HTH>>(v1);
    }

    // decompiled from Move bytecode v6
}

