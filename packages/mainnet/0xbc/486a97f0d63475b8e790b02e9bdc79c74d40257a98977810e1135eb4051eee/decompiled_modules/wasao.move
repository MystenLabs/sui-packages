module 0xbc486a97f0d63475b8e790b02e9bdc79c74d40257a98977810e1135eb4051eee::wasao {
    struct WASAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WASAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WASAO>(arg0, 6, b"WASAO", b"WASAO dog", b"Statue unveiled commemorating popular \"ugly-yet-cute\" Akita dog Wasao", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f1c47ac6_5754_4b78_b969_09e489d49d9a_3616f4d610.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WASAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WASAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

