module 0x6bb082da2bac95e287db39bdba80459da60d1407c6ee29270c7ece4e833aec24::aqua {
    struct AQUA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUA>(arg0, 8, b"AQUA", b"AquaWave", b"gem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR__kdTKYb9KLDHHS_E6gjUXfnfQj-IGTDHql6mcZ6Y90yFBZmo8bBAUuxGhNm-KAVWvRY&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AQUA>(&mut v2, 70000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AQUA>>(v1);
    }

    // decompiled from Move bytecode v6
}

