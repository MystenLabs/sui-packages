module 0x79c3053bc9eafde5f6e7ee011535d982f03a260740e326ec075fef97c94a0310::bluefish {
    struct BLUEFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEFISH>(arg0, 6, b"BlueFish", b"FishBlue", b"We Will to king of the sea with community ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004642_0b0b5629d9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

