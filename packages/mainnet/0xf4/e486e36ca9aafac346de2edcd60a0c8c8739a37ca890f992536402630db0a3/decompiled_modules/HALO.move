module 0xf4e486e36ca9aafac346de2edcd60a0c8c8739a37ca890f992536402630db0a3::HALO {
    struct HALO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HALO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HALO>(arg0, 9, b"HALO", b"HALO", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HALO>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HALO>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<HALO>>(0x2::coin::mint<HALO>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

