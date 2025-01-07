module 0xe08bff8191b321e01f42d786665b933feaca3a742d973e4a5f0e6374d72cf3c2::PHONG {
    struct PHONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHONG>(arg0, 9, b"PHONG", b"PHONG", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PHONG>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PHONG>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<PHONG>>(0x2::coin::mint<PHONG>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

