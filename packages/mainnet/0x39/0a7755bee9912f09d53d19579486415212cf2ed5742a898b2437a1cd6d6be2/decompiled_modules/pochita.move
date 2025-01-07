module 0x390a7755bee9912f09d53d19579486415212cf2ed5742a898b2437a1cd6d6be2::pochita {
    struct POCHITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: POCHITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POCHITA>(arg0, 6, b"Pochita", b"Pochita Next DODGE", x"4f4720446f646765206d6f6d20676f74206d652120506f636869746121204c46470a0a4120796561722073696e63652042616c6c747a6573206465706172747572652c207765206172652066696e616c6c792077656c636f6d696e672061206e6577206d656d6265722c206d65657420506f63686974612020", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pochita_836f294ce0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POCHITA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POCHITA>>(v1);
    }

    // decompiled from Move bytecode v6
}

