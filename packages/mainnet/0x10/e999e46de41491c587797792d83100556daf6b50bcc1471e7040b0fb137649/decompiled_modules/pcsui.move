module 0x10e999e46de41491c587797792d83100556daf6b50bcc1471e7040b0fb137649::pcsui {
    struct PCSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PCSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PCSUI>(arg0, 6, b"PCSUI", b"PSYCATSUI", b"Let's create memorable memories with PsyCat on Suinetwork!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_877fcbe092.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PCSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PCSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

