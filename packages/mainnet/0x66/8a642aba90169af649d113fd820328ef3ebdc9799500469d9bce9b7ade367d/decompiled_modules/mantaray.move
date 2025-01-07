module 0x668a642aba90169af649d113fd820328ef3ebdc9799500469d9bce9b7ade367d::mantaray {
    struct MANTARAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANTARAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANTARAY>(arg0, 6, b"MANTARAY", b"Manta Ray", b"Introducing Manta Ray,  inspired by the majestic creature known for its grace and agility in the ocean. Here to conquer the Sui Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Manta_Ray_a6e34367dc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANTARAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MANTARAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

