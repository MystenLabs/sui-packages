module 0x859ba906e40381bd1ccf26404b87537926f3b26a58ebf6fe1aa0f07f51471d70::asd {
    struct ASD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASD>(arg0, 6, b"ASD", b"Astroid", b"Asteroid was designed by Liv P, honorary member of the Polaris Dawn Team & Pediatric Cancer Survivor. At her request, proceeds from the sale of Asteroid will go to St. Jude Children's Research Hospital", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/astroid3_ee2b603e13.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASD>>(v1);
    }

    // decompiled from Move bytecode v6
}

