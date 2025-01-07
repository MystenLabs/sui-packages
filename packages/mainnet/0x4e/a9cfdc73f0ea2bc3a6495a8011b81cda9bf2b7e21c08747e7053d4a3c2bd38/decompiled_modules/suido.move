module 0x4ea9cfdc73f0ea2bc3a6495a8011b81cda9bf2b7e21c08747e7053d4a3c2bd38::suido {
    struct SUIDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDO>(arg0, 6, b"SUIDO", b"SUIDO - THE BLUE MASCOT OF SUI", b"The first REAL CTO on Move.Pump. $SUIDO was launched last week - and I, alongside many others, had a bag. The dev dumped, and in turn fumbled the biggest opportunity of his life. That's why I've created this CTO, to take the Matt Furie Based Blue Mascot of SUI where he belongs - to the MILLIONS! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_91_adc3dde973.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

