module 0x215ee4f8656756284f0d7bd3b4b9de9b4584efd2ec5b49f34bc98f8a923d83e0::grendel {
    struct GRENDEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRENDEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRENDEL>(arg0, 9, b"GRENDEL", b"Grendel", b"GRENDEL IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/887/656/large/joan-francesc-oliveras-pallerols-grendel.jpg?1728819098")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GRENDEL>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRENDEL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRENDEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

