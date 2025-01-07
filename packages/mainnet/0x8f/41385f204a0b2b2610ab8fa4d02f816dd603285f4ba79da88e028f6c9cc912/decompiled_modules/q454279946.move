module 0x8f41385f204a0b2b2610ab8fa4d02f816dd603285f4ba79da88e028f6c9cc912::q454279946 {
    struct Q454279946 has drop {
        dummy_field: bool,
    }

    fun init(arg0: Q454279946, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<Q454279946>(arg0, 9, b"Q454279946", x"5741564520f09f8c8a", b"wewe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/efdf1c41-f012-4c06-8d48-bcfee237fe16.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<Q454279946>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<Q454279946>>(v1);
    }

    // decompiled from Move bytecode v6
}

