module 0x9e4550b6c6bc34e0de033ab65ae30a348835eed1e7683679b97d5eb12682ffcf::q42024 {
    struct Q42024 has drop {
        dummy_field: bool,
    }

    fun init(arg0: Q42024, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<Q42024>(arg0, 9, b"Q42024", b"Dogs@pigs", b"Happy happy dogs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/631bf957-a925-413e-af76-79680c550cbb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<Q42024>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<Q42024>>(v1);
    }

    // decompiled from Move bytecode v6
}

