module 0xd19e30253aaa9da3b17981f418b00dd520794765fac2160c761372c697d061bc::tingus {
    struct TINGUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TINGUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TINGUS>(arg0, 6, b"Tingus", b"Tingus on Sui", b"Official Tingus SUI launch. After the massive succes on SOL, we are here to conquer the Sui chain as well. Join our telegram, have some fun and enjoy the art.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ta_TQW_9vz_400x400_1_fc38db475c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TINGUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TINGUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

