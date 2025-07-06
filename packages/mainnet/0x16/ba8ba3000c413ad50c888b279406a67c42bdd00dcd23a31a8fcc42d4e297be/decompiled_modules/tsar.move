module 0x16ba8ba3000c413ad50c888b279406a67c42bdd00dcd23a31a8fcc42d4e297be::tsar {
    struct TSAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSAR>(arg0, 9, b"TSAR", b"tsar", b"bomba", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/1b1d3661-4b3b-49ac-928f-d20146ecc0e2.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TSAR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSAR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

