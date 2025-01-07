module 0x3293ef8893d2df3c173b1f284222fed1c84af8df6eaa49f55fdf554b22f82464::nidyaroy {
    struct NIDYAROY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIDYAROY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIDYAROY>(arg0, 9, b"NIDYAROY", b"NIDYS", b"Nida aku akan ada", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/56cbf66c-f215-4799-a348-998ffff3d8a6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIDYAROY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NIDYAROY>>(v1);
    }

    // decompiled from Move bytecode v6
}

