module 0xcc5ad9fb8f3e9e5cce872c607a4dfec5b5b8401014fff8ecdd49f1c3c87eda8a::cheolsu {
    struct CHEOLSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEOLSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEOLSU>(arg0, 6, b"CHEOLSU", b"Cheol-su", b"Season 2's mascot/Doll for #Squidgame2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000055804_f6777881aa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEOLSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHEOLSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

