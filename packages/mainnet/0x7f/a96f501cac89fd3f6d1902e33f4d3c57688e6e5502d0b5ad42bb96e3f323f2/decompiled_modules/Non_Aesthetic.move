module 0x7fa96f501cac89fd3f6d1902e33f4d3c57688e6e5502d0b5ad42bb96e3f323f2::Non_Aesthetic {
    struct NON_AESTHETIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: NON_AESTHETIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NON_AESTHETIC>(arg0, 9, b"NON", b"Non Aesthetic", b"non aesthetic stuff", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/d4ecaf49-48b4-4b24-8d72-af70a1cd1989.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NON_AESTHETIC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NON_AESTHETIC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

