module 0x9534339478e1d7f668f44b7f7361deaf4a80a1519a676527d6c1045d87e822bc::stonie {
    struct STONIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: STONIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STONIE>(arg0, 6, b"STONIE", b"Stonie", b"Meet Stonie, the highest member of the group. He was so stoned that he missed the invitation to join the Boys' Club.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_17_09_55_04_2aa7a79c34.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STONIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STONIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

