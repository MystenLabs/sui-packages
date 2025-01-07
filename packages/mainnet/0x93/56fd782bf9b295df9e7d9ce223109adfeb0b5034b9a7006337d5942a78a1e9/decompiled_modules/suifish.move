module 0x9356fd782bf9b295df9e7d9ce223109adfeb0b5034b9a7006337d5942a78a1e9::suifish {
    struct SUIFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFISH>(arg0, 6, b"SUIFISH", b"SUI FISH SUI NETWORK", b"SUI FISH Burn ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/11_182e3ce8fd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

