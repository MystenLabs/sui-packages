module 0x4bdfe46c0351608f1f6b94dc1bc22ab673b268458dc7ff4f5e1bfaabc33dca11::biscuits {
    struct BISCUITS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BISCUITS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BISCUITS>(arg0, 6, b"BISCUITS", b"Biscuits ON SUI", b"Biscuits the seal is a baby seal!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hs71b6ys_400x400_ca181059e1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BISCUITS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BISCUITS>>(v1);
    }

    // decompiled from Move bytecode v6
}

