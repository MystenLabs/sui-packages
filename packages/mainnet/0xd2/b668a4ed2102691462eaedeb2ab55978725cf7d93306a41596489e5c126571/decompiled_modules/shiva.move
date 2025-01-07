module 0xd2b668a4ed2102691462eaedeb2ab55978725cf7d93306a41596489e5c126571::shiva {
    struct SHIVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIVA>(arg0, 6, b"SHIVA", b"Shiva inu", x"534849564120494e550a5574696c697a696e6720636f6d6d756e69747920706f77657220696e207468652067726f77696e6720544f4e20446546692065636f73797374656d2e0a0a412050726f706572206d656d65636f696e2c20446f6e65207269676874", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000039042_f7c45a24d2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIVA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIVA>>(v1);
    }

    // decompiled from Move bytecode v6
}

