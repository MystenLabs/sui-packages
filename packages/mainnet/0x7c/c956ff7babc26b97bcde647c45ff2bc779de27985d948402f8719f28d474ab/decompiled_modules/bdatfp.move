module 0x7cc956ff7babc26b97bcde647c45ff2bc779de27985d948402f8719f28d474ab::bdatfp {
    struct BDATFP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BDATFP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BDATFP>(arg0, 6, b"BDATFP", b"Blue Dino and the Fish Planter", b"Positioned in the foreground, the dinosaur resembles a bipedal species, possibly a miniature representation of a herbivorous dinosaur like a Brachiosaurus or a smaller dinosaur in blue and green tones.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZ_2_Zkmhbg_AA_J_Lq_af28552140.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BDATFP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BDATFP>>(v1);
    }

    // decompiled from Move bytecode v6
}

