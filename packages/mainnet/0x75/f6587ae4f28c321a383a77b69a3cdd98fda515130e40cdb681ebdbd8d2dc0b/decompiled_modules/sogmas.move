module 0x75f6587ae4f28c321a383a77b69a3cdd98fda515130e40cdb681ebdbd8d2dc0b::sogmas {
    struct SOGMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOGMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOGMAS>(arg0, 6, b"SOGMAS", b"Sogmas", b"No Socials, dex will be paid upon bonding.Lets take it to the million!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000006859_f4662e4c09.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOGMAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOGMAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

