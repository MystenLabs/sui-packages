module 0xd4af546d7f671bb7efb23fd7e01746b9ed58286d4ad79018ea66b1b6ddbc2063::scs {
    struct SCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCS>(arg0, 9, b"SCS", b"Suicats", b"meow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/dcda088f0cd736e2141f60714d9e5274blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

