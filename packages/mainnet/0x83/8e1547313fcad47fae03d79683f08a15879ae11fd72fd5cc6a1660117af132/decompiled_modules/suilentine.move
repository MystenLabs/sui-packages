module 0x838e1547313fcad47fae03d79683f08a15879ae11fd72fd5cc6a1660117af132::suilentine {
    struct SUILENTINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILENTINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILENTINE>(arg0, 9, b"SUILENTINE", b"Suilentine's Day", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRKwSvam3TU9hzzEIDl7GGY4Xpu8Vh_Dm_vuQ&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUILENTINE>(&mut v2, 14021403000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILENTINE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILENTINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

