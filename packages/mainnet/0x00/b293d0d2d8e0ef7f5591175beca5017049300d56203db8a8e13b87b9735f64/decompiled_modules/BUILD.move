module 0xb293d0d2d8e0ef7f5591175beca5017049300d56203db8a8e13b87b9735f64::BUILD {
    struct BUILD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUILD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUILD>(arg0, 9, b"BUILD", b"BUILD", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUILD>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BUILD>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<BUILD>>(0x2::coin::mint<BUILD>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

