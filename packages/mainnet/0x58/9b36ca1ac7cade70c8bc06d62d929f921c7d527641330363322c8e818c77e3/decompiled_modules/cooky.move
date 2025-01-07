module 0x589b36ca1ac7cade70c8bc06d62d929f921c7d527641330363322c8e818c77e3::cooky {
    struct COOKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOKY>(arg0, 6, b"COOKY", b"SUI COOKY", b"cooky is the cutest cookies I have ever see. he is always stand there and will never go down", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/COOKY_3820e93a4f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COOKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

