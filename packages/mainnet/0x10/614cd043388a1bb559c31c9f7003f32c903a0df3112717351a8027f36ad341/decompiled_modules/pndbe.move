module 0x10614cd043388a1bb559c31c9f7003f32c903a0df3112717351a8027f36ad341::pndbe {
    struct PNDBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNDBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNDBE>(arg0, 9, b"PNDBE", b"ueje", b"hebd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/90387c43-77bb-4de5-82dc-dc6291d5fef9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNDBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PNDBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

