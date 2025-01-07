module 0x9bf255dc5dbe73ecc33119abb70c0262ad7f069d1ec2a046caab2cb3ed20b19f::adaq {
    struct ADAQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADAQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADAQ>(arg0, 9, b"ADAQ", b"Muhammad ", b"This is a nice coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7627db28-370f-44d7-8afd-08dd4c362a34.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADAQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADAQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

