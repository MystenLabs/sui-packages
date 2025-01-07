module 0xbef4694f2a5a51acb4993d241ad02e9d87ac3f6a22d71112048e5a1d4899f06b::groot {
    struct GROOT has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 9, b"SUI GROOT", b"GROOT MORNING SUI", b"GROOT MORNING ENGAGE BACK IF YOU SEE IT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://wallpapers-clan.com/wp-content/uploads/2024/07/baby-groot-guardians-of-the-galaxy-wallpaper-preview.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    fun init(arg0: GROOT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<GROOT>(arg0, arg1);
        0x2::coin::mint_and_transfer<GROOT>(&mut v0, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROOT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

