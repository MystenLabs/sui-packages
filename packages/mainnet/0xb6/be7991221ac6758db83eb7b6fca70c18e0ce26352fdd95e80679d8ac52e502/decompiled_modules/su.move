module 0xb6be7991221ac6758db83eb7b6fca70c18e0ce26352fdd95e80679d8ac52e502::su {
    struct SU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SU>(arg0, 6, b"SU", b"Sui Universe", b"At the heart of the\"Sui Universe\" is the concept of fluidity, resilience, and interconnectedness, mirroring Sui's capabilities. Each artwork is meticulously designed with a dominant blue palette symbolizing trust, infinity, and the boundless nature", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1252345_8e7c83a30d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SU>>(v1);
    }

    // decompiled from Move bytecode v6
}

