module 0x318a487b6f49fab57b9b59ec3b8d01ef9106a9a89b0a2ef8f41fa7ee86eadb37::shibsui {
    struct SHIBSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIBSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBSUI>(arg0, 6, b"ShibSui", b"SHI", x"42657374204d656d6520446f6720657665722c206d65657473204265737420426c6f636b636861696e20657665722e0a57656c636f6d6520746f205368696220537569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image0_d4e7412a99.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIBSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

