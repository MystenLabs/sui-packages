module 0x78fbc69d467e3aeb898f7173f8d900bc1a797be0b3fc93e70d09ec8ff18e013::rkt {
    struct RKT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RKT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RKT>(arg0, 9, b"RKT", b"rocket", b"rocket is good", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/76bf159a5863179fa76c8dfcc270e899blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RKT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RKT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

