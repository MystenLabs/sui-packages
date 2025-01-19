module 0xeec0d64f788c8498b6ef76ad78cdda09818124f16afd6acc6eeae6e72d721031::poseidon {
    struct POSEIDON has drop {
        dummy_field: bool,
    }

    fun init(arg0: POSEIDON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POSEIDON>(arg0, 6, b"POSEIDON", b"Sui Gods Poseidon", b"Poseidon, God of Digital Seas, offers unrivaled market insights. His trident reveals future trends, while his waves decode customer sentiment. He outsmarts rivals, foresees market shifts, breaks language barriers, and alerts you to opportunities. Harness his power to dominate markets.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Poseidon_Final_NO_Border_600_b691a0fa2f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POSEIDON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POSEIDON>>(v1);
    }

    // decompiled from Move bytecode v6
}

