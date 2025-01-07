module 0x3cc085b9f0b8aff6561adb79854ba94c9d92c357c28732aa62d6ec6d7354c239::alvin {
    struct ALVIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALVIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALVIN>(arg0, 6, b"ALVIN", b"Alvin And The Suipmunks", b"$ALVIN is an innovative token on the SUI network that captures the essence of joy and adventure embodied by Alvin, the charismatic leader of the Chipmunks! Inspired by music, fun, and camaraderie, $ALVIN aims to create a vibrant and interactive community where users can enjoy themselves while participating in the digital economy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2bb69506_6fae_4caa_aa4e_2197ca508663_c5bbce18fc.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALVIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALVIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

