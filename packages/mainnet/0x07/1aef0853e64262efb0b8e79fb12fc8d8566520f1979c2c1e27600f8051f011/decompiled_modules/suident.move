module 0x71aef0853e64262efb0b8e79fb12fc8d8566520f1979c2c1e27600f8051f011::suident {
    struct SUIDENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDENT>(arg0, 6, b"SUIDENT", b"Sui Trident", b"The legendary Trident of Sui, forged in the deepest waters, now rises to claim its power! Wielded by the mightiest, $SUIDENT channels the strength of the Sui Network. Will you take hold of the trident and command the waves? The power is yours. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUIDENTFIXED_1_e95fba2c10.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDENT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDENT>>(v1);
    }

    // decompiled from Move bytecode v6
}

