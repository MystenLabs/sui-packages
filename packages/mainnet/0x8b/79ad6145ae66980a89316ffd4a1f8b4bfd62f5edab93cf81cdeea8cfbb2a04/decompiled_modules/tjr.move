module 0x8b79ad6145ae66980a89316ffd4a1f8b4bfd62f5edab93cf81cdeea8cfbb2a04::tjr {
    struct TJR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TJR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TJR>(arg0, 6, b"TJr", b"Official Trump Jr Meme", b"Following in the footsteps of my mother and father, to make America stronger.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1001236487_9c863f3bb1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TJR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TJR>>(v1);
    }

    // decompiled from Move bytecode v6
}

