module 0x12f88f0c136dd7a78da9f22ae9ed08ece019ef4c88eed3e60b2453aa73861624::powo {
    struct POWO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POWO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POWO>(arg0, 6, b"POWO", b"The Banana Cyclops Poop", x"204869202120496d20504f574f2021207468652042616e616e61204379636c6f707320506f6f70200a0a45766572796f6e65206b6e6f777320504f574f2c206865277320796f757220667269656e642c20796f7572206e65696768626f72277320667269656e642c0a796f757220646f67277320667269656e642c20796f757220636174277320667269656e642e2e2e206865277320616c736f20456c6f6e204d75736b277320667269656e64", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1062_8cd1be3625.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POWO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POWO>>(v1);
    }

    // decompiled from Move bytecode v6
}

