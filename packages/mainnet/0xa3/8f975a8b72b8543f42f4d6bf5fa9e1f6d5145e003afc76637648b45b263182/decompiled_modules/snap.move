module 0xa38f975a8b72b8543f42f4d6bf5fa9e1f6d5145e003afc76637648b45b263182::snap {
    struct SNAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNAP>(arg0, 6, b"SNAP", b"Snap: first space coin", b"A unique coin \"Snap\" specially designed for the Starlink Polaris Dawn mission went into space with astronauts. The design of the coin was created by an artist and inspired by the natural environment of Cape Florida, including seven stars, representing the astronauts who participated in the mission and the outline of Falcon 9 rocket at sunrise. This coin reached a new height in earth orbit and was taken into space by astronauts during their spacewalk.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20240930_184716_416_2add1dc998.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

