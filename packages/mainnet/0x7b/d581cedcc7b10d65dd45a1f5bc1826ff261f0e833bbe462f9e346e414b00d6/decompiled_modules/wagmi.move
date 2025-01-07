module 0x7bd581cedcc7b10d65dd45a1f5bc1826ff261f0e833bbe462f9e346e414b00d6::wagmi {
    struct WAGMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAGMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAGMI>(arg0, 6, b"WAGMI", b"We are all gonna make it", b"Were sticking it out through thick and thin. This isnt new, and were not giving up. Were all gonna make it, so lets fucking go!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Wagmi_4d514d474e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAGMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAGMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

