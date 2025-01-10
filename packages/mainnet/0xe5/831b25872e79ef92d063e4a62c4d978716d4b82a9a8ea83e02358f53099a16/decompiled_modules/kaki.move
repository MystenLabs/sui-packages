module 0xe5831b25872e79ef92d063e4a62c4d978716d4b82a9a8ea83e02358f53099a16::kaki {
    struct KAKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAKI>(arg0, 6, b"KAKI", b"Kaki On Sui", b"kaki - The best chef on the sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000023180_1fc4995497.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

