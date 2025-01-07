module 0xaccdf5d4e38490d04095aa0b6ef09377252d0593b878de57246459e4f906b021::lsd {
    struct LSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: LSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LSD>(arg0, 6, b"LSD", b"Lysergic Sui Diethylamide", b"Lysergic Sui Diethylamide is the mind-bending journey of the crypto realm, taking its holders on a surreal trip through the ever-changing landscape of the blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/asd123_a4c77b790f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

