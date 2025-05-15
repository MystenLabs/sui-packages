module 0x7fb4538e259f2e6874b30d1aa2172fb48530cbd02867cac15fd3f8d112d2e826::bartt {
    struct BARTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARTT>(arg0, 6, b"BARTT", b"Bartt", b"$BARTT. Merges the iconic characters of Brett and Bart Simpson into the Trenches of Sui Blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/barttlogo_38e8f4a2d6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BARTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

