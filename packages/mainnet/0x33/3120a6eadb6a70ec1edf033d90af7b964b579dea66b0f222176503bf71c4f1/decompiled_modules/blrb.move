module 0x333120a6eadb6a70ec1edf033d90af7b964b579dea66b0f222176503bf71c4f1::blrb {
    struct BLRB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLRB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLRB>(arg0, 6, b"BLRB", b"Blorbo", b"Blorbo is a frog with wide eyes and a loveable grin. With a golden crown perched on his head, he reigns supreme over the Base blockchain in his own charming way", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Black_and_White_House_Real_Estate_Logo_20250502_194358_0000_841f7929f2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLRB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLRB>>(v1);
    }

    // decompiled from Move bytecode v6
}

