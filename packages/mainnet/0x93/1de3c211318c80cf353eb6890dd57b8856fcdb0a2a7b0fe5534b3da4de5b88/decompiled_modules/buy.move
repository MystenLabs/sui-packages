module 0x931de3c211318c80cf353eb6890dd57b8856fcdb0a2a7b0fe5534b3da4de5b88::buy {
    struct BUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUY>(arg0, 6, b"BUY", b"YOU WILL BUY", b"YOU WILL BUY,YOU HAVE TO BUY,YOU WANT TO BUY,YOU ARE GOING TO BUY,YOU ARE THINKING OF BUYING,LOOK INTO THE VOID AND YOU WILL KNOW THAT YOU HAVE TO BUY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/full_frame_hypnotic_spiral_background_2_HWEC_4_E_2c1043157f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUY>>(v1);
    }

    // decompiled from Move bytecode v6
}

