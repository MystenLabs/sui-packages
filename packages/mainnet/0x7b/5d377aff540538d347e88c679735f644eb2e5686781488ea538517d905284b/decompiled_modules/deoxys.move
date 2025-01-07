module 0x7b5d377aff540538d347e88c679735f644eb2e5686781488ea538517d905284b::deoxys {
    struct DEOXYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEOXYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEOXYS>(arg0, 9, b"DEOXYS", b"Deoxys", b"DEOXYS IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/238/828/large/alexandre-mougenot-deoxys-closeup-01.jpg?1727078194")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DEOXYS>(&mut v2, 50000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEOXYS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEOXYS>>(v1);
    }

    // decompiled from Move bytecode v6
}

