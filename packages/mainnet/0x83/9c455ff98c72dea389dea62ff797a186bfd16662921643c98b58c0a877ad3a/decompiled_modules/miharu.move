module 0x839c455ff98c72dea389dea62ff797a186bfd16662921643c98b58c0a877ad3a::miharu {
    struct MIHARU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIHARU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIHARU>(arg0, 6, b"Miharu", b"$MIHARU", b"A dolphin with a charming smile,his name is Miharu on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/000_73d5c11e8c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIHARU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIHARU>>(v1);
    }

    // decompiled from Move bytecode v6
}

